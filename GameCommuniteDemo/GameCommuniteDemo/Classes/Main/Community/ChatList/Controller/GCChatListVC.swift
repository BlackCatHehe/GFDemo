//
//  GCChatListVC.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/16.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import NIMSDK
class GCChatListVC: GCBaseVC {
    
    ///数据源
    private var allChats: [NIMRecentSession] = []
    
    ///必须在主线程获取（只有每次刷新页面时才赋值给数据源）
    private var chatList: [NIMRecentSession] {
        get {
            let chats = NIMSDK.shared().conversationManager.allRecentSessions() ?? []
             
            return chats
        }
    }

    deinit{
        print("GCChatListVC.deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allChats = chatList
        
        initTableView()
        
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().loginManager.add(self)
    }
    
    //MARK: - lazyload
    private lazy var tableview: UITableView = {[weak self] in
        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.backgroundColor = MetricGlobal.mainBgColor
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = adaptW(70.0)
        self?.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        }
        return tableV
        }()
}

extension GCChatListVC {
    
    private func initTableView() {
        tableview.register(cellType: GCChatListCell.self)
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kScreenH - kTabBarHeight - kStatusBarheight - kNavBarHeight)
        }
    }
}

extension GCChatListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adaptW(10.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let session = allChats[indexPath.row]
        
//        if let friendId = session.session?.sessionId {
//            if let user = NIMSDK.shared().userManager.userInfo(friendId) {
//                print(user.userInfo?.nickName)
//                print(user.userInfo?.avatarUrl)
//                print(session.lastMessage?.text)
//                print(session.unreadCount)
//            }
//        }
//
        let cell: GCChatListCell = tableView.dequeueReusableCell(for: indexPath, cellType: GCChatListCell.self)
        cell.setModel(session)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cSession = allChats[indexPath.row]
        guard let session = cSession.session else {
            return
        }
        
        let vc = GCChatVC(chat: session)
        push(vc)
    }
}

extension GCChatListVC: NIMLoginManagerDelegate {
    
    func onLogin(_ step: NIMLoginStep) {
        if step == .syncOK {
            allChats = chatList
            tableview.reloadData()
        }
    }
}

extension GCChatListVC: NIMConversationManagerDelegate {
    
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
        allChats.append(recentSession)
        guard allChats.count < 2 else {return}
        allChats.sort {$0.lastMessage!.timestamp > $1.lastMessage!.timestamp}
        
        tableview.reloadData()
    }
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        JYLog("移除旧元素")
        for (idx, item) in allChats.enumerated() {
            if item.session?.sessionId == recentSession.session?.sessionId {
                allChats.remove(at: idx)
                break
            }
        }
        JYLog("添加到新位置")
        var newIndex = allChats.count
        for (idx, item) in allChats.enumerated() {
            if recentSession.lastMessage!.timestamp >= item.lastMessage!.timestamp {
                newIndex = idx
                break
            }
        }
        allChats.insert(recentSession, at: newIndex)
        tableview.reloadData()
    }
    
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
    }
}
