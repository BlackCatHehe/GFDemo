//
//  GCChatVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/11/21.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import NIMSDK
import MJRefresh

class GCChatVC: GCBaseVC {

    var session: NIMSession
    
    private var isFirstEnter: Bool = true
    
    ///消息列表
    private var chatLists: [NIMMessage] = []
    
    ///获取历史消息的标记(保持为chatLists的第一个)
    private var archerMessage: NIMMessage? {
        get {
            return chatLists.count == 0 ? nil : chatLists.first
        }
    }
    
    ///获取本地历史消息记录（只有15条,需要查看历史记录时引用并更新到消息列表chatLists中）
    private var historyChatMsgs: [NIMMessage]  {
        get {
            if let msgs = NIMSDK.shared().conversationManager.messages(in: session, message: archerMessage, limit: 15) {
                return msgs
            }else {
                return []
            }  
        }
    }
    
    init(chat session: NIMSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "聊天"
        
        if let user = NIMSDK.shared().userManager.userInfo(session.sessionId) {
            title = user.userInfo?.nickName
        }
        
        //当新增一条消息，并且本地不存在该消息所属的会话时，会触发此回调
        NIMSDK.shared().chatManager.add(self)
        
        initUI()
        
        //进入聊天时获取本地最新15条聊天记录
        chatLists = historyChatMsgs
        
        //显示最下方
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.tableview.scrollToRow(at: IndexPath(row: chatLists.count - 1, section: 0), at: .bottom, animated: false)
//    }
    
    deinit{
        print("GCChatVC.deinit")
    }
    
    private lazy var tableview: UITableView = {[weak self] in
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.backgroundColor = MetricGlobal.mainBgColor
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.dataSource = self
        if #available(iOS 11.0, *) {
            tableview.contentInsetAdjustmentBehavior = .never
        }
        return tableview
    }()
    
    private lazy var bCommentV: GCCommentInputView = {
        let v = GCCommentInputView()
        return v
    }()

}

extension GCChatVC {
    
    private func initUI() {
        tableview.register(cellType: GCOtherMsgCell.self)
        tableview.register(cellType: GCMyMsgCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarheight + kNavBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomH - adaptW(48.0))
        }
        let mjHeader = MJRefreshNormalHeader {
            let historys = self.historyChatMsgs
            guard historys.isEmpty == false else {
                self.tableview.mj_header.endRefreshing()
                return
            }
            
            self.chatLists.insert(contentsOf: historys, at: 0)
            self.tableview.mj_header.endRefreshing()
            self.tableview.reloadData()
            self.tableview.scrollToRow(at: IndexPath(row: historys.count - 1, section: 0), at: .top, animated: false)
        }
        mjHeader?.lastUpdatedTimeLabel.isHidden = true
        mjHeader?.stateLabel.isHidden = true
        tableview.mj_header = mjHeader
        
        view.addSubview(bCommentV)
        bCommentV.delegate = self
        bCommentV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()

            make.right.left.equalToSuperview() 
        }
    }
    
    ///发送消息
    private func pushMsg(_ text: String) {
        let msg = NIMMessage()
        msg.text = text
        
        //推送样式
        
        msg.apnsContent = "发来了一条消息"
       // msg.apnsPayload = ["sessionId" : session.sessionId]
        let setting = NIMMessageSetting()
        setting.apnsEnabled = true
        setting.scene = NIMNOSSceneTypeMessage
        msg.setting = setting
        NIMSDK.shared().chatManager.send(msg, to: session) { (error) in
            if error == nil {
                JYLog("云信 -- 发送成功")
                self.bCommentV.clearMsg()
                
                self.chatLists.append(msg)
                let indexPath = IndexPath(row: self.chatLists.count - 1, section: 0)
                self.tableview.beginUpdates()
                self.tableview.insertRows(at: [indexPath], with: .none)
                self.tableview.endUpdates()
                
                self.tableview.scrollToRow(at: indexPath, at: .bottom, animated: false)

            }else {
                self.showToast("发送消息失败了,请重试")
                JYLog("云信发送出错: \(error!.localizedDescription)")
            }
        }
    }
}

extension GCChatVC: GCCommentInputViewDelegate {
    
    func inputViewDidClickEmoji(inputView: GCCommentInputView) {
        
    }
    
    func inputView(inputView: GCCommentInputView, didClickPost text: String) {
        
        guard text.isEmpty() == false else {
            showToast("不能发送空消息")
            return
        }
        
        pushMsg(text)
    }

}

extension GCChatVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLists.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = chatLists[indexPath.row]
        
        //自己的消息，senderName = nil
        let accId = GCUserDefault.shareInstance.userInfo!.neteasyAccid!
        
        if msg.from != accId {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GCOtherMsgCell.self)
            cell.setModel(isHaveTime: false, message: msg)
            return cell
        }else {
           let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GCMyMsgCell.self)
            cell.setModel(isHaveTime: false, message: msg)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return adaptW(60.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isFirstEnter == true {
            isFirstEnter = false
            self.tableview.scrollToRow(at: IndexPath(row: chatLists.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension GCChatVC: NIMChatManagerDelegate {
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        JYLog(messages)
        
        chatLists.append(contentsOf: messages)
        
        var indexPaths: [IndexPath] = []
        for idx in 0..<messages.count {
            let indexPath = IndexPath(row: chatLists.count - messages.count + idx, section: 0)
            indexPaths.append( indexPath)
        }
        
        tableview.beginUpdates()
        tableview.insertRows(at: indexPaths, with: .none)
        tableview.endUpdates()
    
    }

}
