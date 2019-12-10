//
//  MXTNetTool.swift
//  mingxint
//
//  Created by payTokens on 2019/4/18.
//  Copyright © 2019 放. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import KeychainAccess
public let baseImgUrl = "http://res.uioj.com"
#if DEBUG
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#else
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#endif

enum GCNetApi {
    //TODO: login
    case register(prama: [String: String]) //注册
    case sendCode(prama: [String: String]) //发送验证码
    case resignLogin //退出登录
    
    //TODO: user
    case getUserInfo(uId: Int) //获取用户信息
    case updateUserInfo(prama: [String: Any]) //修改用户信息
    
    //TODO: communite
    case communiteList//社区列表
    case createCommunite(prama: [String: String])//创建社区
    case joinCommunite(prama: String)//加入社区
    case exitCommunite(prama: String)//退出社区
    case communiteDetail(prama: String)//社区详情
    case topicList(tid: String, prama: [String: Any])//话题列表
    case postTopic(prama: [String: Any])//发布话题
    case topicDetail(prama: String)//话题详情
    case topicTapZan(prama: String)//话题点赞
    case topicCancelZan(prama: String)//话题取消点赞
    case communiteMemberList(cid: Int)//社区成员列表
    
    //TODO: updateImg
    case updateImg(prama: [String : String], images: [UIImage])//上传图片
    
    //TODO: 评论
    case commentList(prama: [String : Int])//评论列表
    case postComment(prama: [String : Any])//发起评论
    case commentReplyList(prama: [String : Int])//回复列表
    case postCommentReply(prama: [String : Any])//发起回复
    case commentTapZan(commentId: String)//评论点赞
    case commentCancelZan(commentId: String)//评论取消点赞
    
    //TODO: goods
    case goodsCate//商品分类
    case goodsList(prama: [String : Any])//商品列表
    case goodsDetail(gid: String, prama: [String: String])//商品详情
    case goodsPost(prama: [String : Any])//商品发布
    case goodsDown(prama: String)//商品下架
    case goodsReEdit(id: String, prama: [String : String])//商品重新编辑
    case goodsSortPramas //关联商品筛选参数列表
    case goodsDelete(gid: Int) //关联商品筛选参数列表
    
    //TODO: pay
    case createOrder(prama: [String: Any])//创建订单
    case orderBuyList([String : Any])//我购买的订单列表
    case orderSaleList([String : Any])//我卖出订单列表
    case orderPay([String : Int])//支付订单
    
    //TODO: recommend
    case banner(prama: [String : Int])//推荐页轮播图
    case centerNews//推荐页中间三项
    case newsZiXun//推荐页最新资讯
    
    //TODO: 我的
    case myTopics  //我的话题列表
    case eState    //财产明细
    case myItems(prama: [String: Any])   //我的道具
    case goodsManager(prama: [String: Any])  //商品管理
    case feedback(prama: [String: Any]) //意见反馈
    case aboutUs //关于我们
    
    //TODO: 消息中心
    case cheaperActivities(prama: [String : Int])//优惠活动
    case notiMsgs(prama: [String : Int])//通知消息
    case msgZanList(prama: [String : Int])//赞和评论（赞）
    case msgCommentList(prama: [String : Int])//赞和评论（评论）
    
    //TODO: 关注
    case follow(userId: Int) //关注用户
    case cancelFollow(prama: Int) //取消关注用户
    
    //TODO: 热门游戏
    case hotGameDetail(userId: Int) //精选游戏详情
    case hotGameList(prama: [String: Any]) //精选游戏列表
    
    //TODO: 搜索
    case search(prama: [String: Any]) //搜索
}

extension GCNetApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        
        switch self {
        //TODO: login
        case .register:
            return "users"
        case .sendCode:
            return "verificationCodes"
            
        case .resignLogin:
            return "authorizations"
            
        //TODO: user
        case let .getUserInfo(uId): //获取用户信息
            return "users/\(uId)"
        case .updateUserInfo: //修改用户信息
            return "user"
            
        //TODO: communite
        case .communiteList:
            return "communities"
        case .createCommunite:
            return "communities"
        case let .joinCommunite(communiteId):
            return "community/members/\(communiteId)"
        case let .exitCommunite(communiteId):
            return "community/members/\(communiteId)"
        case let .communiteDetail(communiteId):
            return "communities/\(communiteId)"
        case let .topicList(tid, _):
            return "community/\(tid)/topics"
        case .postTopic:
            return "topics"
        case let .topicDetail(topicId):
            return "topics/\(topicId)"
        case let .topicTapZan(topicId):
            return "topic/praises/\(topicId)"
        case let .topicCancelZan(topicId):
            return "topic/praises/\(topicId)"
        case let .communiteMemberList(cid)://社区成员列表
            return "community/\(cid)/members"
            
        //TODO: updateImg
        case .updateImg:
            return "images"
            
        //TODO: 评论
        case .commentList: //评论列表
            return "comments"
        case .postComment://发起评论
            return "comments"
        case .commentReplyList://回复列表
            return "replies"
        case .postCommentReply://发起回复
            return "replies"
        case let .commentTapZan(commentId)://评论点赞
            return "comment/praises/\(commentId)"
        case let .commentCancelZan(commentId)://评论取消点赞
            return "comment/praises/\(commentId)"
            
        //TODO: goods
        case .goodsCate: //商品分类
            return "ornamentCategories"
        case .goodsList://商品列表
            return "ornaments"
        case let .goodsDetail(gid, _)://商品详情
            return "ornaments/\(gid))"
        case .goodsPost: //商品发布
            return "ornaments"
        case let .goodsDown(prama)://商品下架
            return "ornaments/\(prama)/down"
        case let .goodsReEdit(id, _)://商品重新编辑
            return "ornaments/\(id)"
        case .goodsSortPramas: //商品筛选参数
            return "searchParam"
        case let .goodsDelete(gid): //关联商品筛选参数列表
            return "ornaments/\(gid)"
            
        //TODO: pay
        case .createOrder://创建订单
            return "orders"
        case .orderBuyList://订单列表
            return "orders"
        case .orderSaleList://订单列表
            return "user/sales"
        case .orderPay://支付订单
            return "payments"
            
        //TODO: recommend
        case .banner://推荐页轮播图
            return "ads"
        case .centerNews://推荐页中间三项
            return "activities/newest"
        case .newsZiXun://推荐页最新资讯
            return "topics/recommends"
            
        //TODO: mine
        case .myTopics://我的话题列表
            return "user/topics"
        case .eState://财产明细
            return "user/ethLogs"
        case .myItems:   //我的道具
            return "user/props"
        case .goodsManager:  //商品管理
            return "user/ornaments"
        case .feedback:  //意见反馈
            return "suggests"
        case .aboutUs: //关于我们
            return "about"
            
        //TODO: 消息中心
        case .cheaperActivities://优惠活动
            return "messages/activities"
        case .notiMsgs://通知消息
            return "messages/systems"
        case .msgZanList://赞和评论（赞）
            return "messages/links"
        case .msgCommentList://赞和评论（评论）
            return "messages/comments"
            
        //TODO: 关注
        case let .follow(userId): //关注用户
            return "user/followers/\(userId)"
        case let .cancelFollow(userId): //取消关注用户
            return "user/followers/\(userId)"
            
        //TODO: 热门游戏
        case let .hotGameDetail(gameId): //精选游戏详情
            return "games/\(gameId)"
        case .hotGameList: //精选游戏列表
            return "games"
            
        //TODO: 搜索
        case .search: //搜索
            return "search"
        }
    }
    
    var method: Moya.Method {
        
        switch self{
            
        case .communiteList, .topicList, .getUserInfo, .communiteDetail, .topicDetail, .goodsCate, .goodsList, .goodsDetail, .orderBuyList, .orderSaleList,.newsZiXun, .banner, .centerNews, .commentList, .myTopics, .eState, .cheaperActivities, .notiMsgs, .msgZanList, .msgCommentList, .commentReplyList, .communiteMemberList, .myItems, .goodsManager, .goodsSortPramas, .hotGameList, .hotGameDetail, .search, .aboutUs:
            return .get
        case .topicCancelZan, .resignLogin, .commentCancelZan, .cancelFollow, .exitCommunite, .goodsDelete:
            return .delete
        case .goodsReEdit, .updateUserInfo, .goodsDown:
            return .patch
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "just for test")!
    }
    
    var task: Task {
        switch self {
        //TODO: login
        case let .register(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .sendCode(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .resignLogin:
            return .requestPlain
            
        //TODO: user
        case .getUserInfo: //获取用户信息
            return .requestPlain
        case let .updateUserInfo(prama): //修改用户信息
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
            
        //TODO: communite
        case  .communiteList, .communiteDetail:
            return .requestPlain
        case let .createCommunite(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case  .joinCommunite:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case  .exitCommunite:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case let .postTopic(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .topicList(_, prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .topicDetail:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .topicTapZan, .topicCancelZan:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .communiteMemberList://社区成员列表
            return .requestPlain
            
        //TODO: updateImg
        case let .updateImg(prama, images):
            var imgDatas = [MultipartFormData]()
            for (index, img) in images.enumerated() {
                let data = img.jpegData(compressionQuality: 0.6)
                let timeStamp =  Int(Date().timeIntervalSince1970)
                var timeStr = timeStamp.formatTimeStamp(with: "YYYYMMddhhmmss")
                timeStr = timeStr.appendingFormat("-%i.jpg", index)
                JYLog("pngName:\(timeStr)")
                let formData = MultipartFormData(provider: .data(data!), name: "image", fileName: timeStr, mimeType: "image/jpg")
                imgDatas.append(formData)
            }
            return .uploadCompositeMultipart(imgDatas, urlParameters: prama)
            
        //TODO: 评论
        case let .commentList(prama)://评论列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .postComment(prama)://发起评论
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .commentReplyList(prama)://回复列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .postCommentReply(prama)://发起回复
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .commentTapZan://评论点赞
            return .requestPlain
        case .commentCancelZan://评论取消点赞
            return .requestPlain
            
        //TODO: goods
        case .goodsCate: //商品分类
            return .requestPlain
        case let .goodsList(prama)://商品列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .goodsDetail(_, prama)://商品详情
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .goodsPost(prama): //商品发布
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .goodsDown://商品下架
            return .requestPlain
        case let .goodsReEdit(_, prama)://商品重新编辑
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .goodsSortPramas://商品筛选参数
            return .requestPlain
         case .goodsDelete: //关联商品筛选参数列表
             return .requestPlain
        
        //TODO: pay
        case let .createOrder(prama)://创建订单
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .orderBuyList(prama)://订单列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .orderSaleList(prama)://订单列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .orderPay(prama)://支付订单
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
            
        //TODO: recommend
        case let .banner(prama)://推荐页轮播图
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .centerNews://推荐页中间三项
            return .requestPlain
        case .newsZiXun://推荐页最新资讯
            return .requestPlain
            
        //TODO: mine
        case .myTopics://我的话题列表
            return .requestPlain
        case .eState://财产明细
            return .requestPlain
        case let .myItems(prama):   //我的道具
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .goodsManager(prama):  //商品管理
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .feedback(prama):  //意见反馈
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .aboutUs: //关于我们
            return .requestPlain
            
        //TODO: 消息中心
        case let .cheaperActivities(prama)://优惠活动
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .notiMsgs(prama)://通知消息
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .msgZanList(prama)://赞和评论（赞）
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .msgCommentList(prama)://赞和评论（评论）
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
            
        //TODO: 关注
        case .follow: //关注用户
            return .requestPlain
        case .cancelFollow: //取消关注用户
            return .requestPlain
            
        //TODO: 热门游戏
        case .hotGameDetail: //精选游戏详情
            return .requestPlain
        case let .hotGameList(prama): //精选游戏列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
            
        //TODO: 搜索
        case let .search(prama): //搜索
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        }
    
    }
    
    var headers: [String : String]? {
        
        if let user = GCUserDefault.shareInstance.userInfo {
            if let userTokenType = user.meta?.tokenType, let userToken = user.meta?.accessToken {
                return ["Authorization" : userTokenType + userToken]
            }else {
                return [:]
            }
        }else {
            return [:]
        }
    }
}


class GCNetTool {
    static private var noNetView: GCNoNetView?
    
    static func requestData<T: TargetType>(target: T, controller: UIViewController? = nil, showAcvitity: Bool = false, isTapAble: Bool = false, success: @escaping (_ responseData: [String : Any]) ->(), fail: @escaping (_ error: MoyaError?)->()){
        
        JYLog("请求接口为: \(target.path)")
        
        //视图的处理
        var acvitityView: UIView!
        if controller != nil {
            acvitityView = controller?.view
        }else {
            acvitityView = kWindow
        }
        
        //无网络时显示无网络页面
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let net = appDelegate.netMoniter {
                if !net.isReachable {
                    if self.noNetView == nil {
                        let noNetV = GCNoNetView(frame: acvitityView.bounds)
                        noNetV.refreshClourse = {
                            self.requestData(target: target, controller: controller, showAcvitity: showAcvitity, isTapAble: isTapAble, success: success, fail: fail)
                        }
                        
                        noNetV.netMoniterClourse = {
                            switch net.networkReachabilityStatus {
                            case .notReachable:
                                acvitityView.showCustomToast("未连接到网络")
                            case .unknown:
                                acvitityView.showCustomToast("未知网络")
                            case .reachable(.ethernetOrWiFi):
                                acvitityView.showCustomToast("当前为wifi网络")
                            case .reachable(.wwan):
                                acvitityView.showCustomToast("当前为移动网络")
                            }
                        }
                        acvitityView.addSubview(noNetV)
                        self.noNetView = noNetV
                    }
                    return
                }else {
                    self.noNetView?.removeFromSuperview()
                    self.noNetView = nil
                } 
            }
        }
        
        //设置请求发起者
        let provider = MoyaProvider<T>()
        
        //是否隐藏菊花
        if showAcvitity {
            acvitityView.showGifLoad()
            acvitityView.isUserInteractionEnabled = isTapAble
        }
        
        //发起请求
        
        provider.request(target) { (result) in
            switch result{
                
            //请求成功
            case let .success(response):
                
                print("===========请求成功===========")
                if showAcvitity {
                    acvitityView.hiddenGifLoad()
                    acvitityView.isUserInteractionEnabled = true
                }
                
                
                //过滤http状态码
                do {
                    let resultResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                    //解析json数据
                    if let data = try? resultResponse.mapJSON() as? [String : Any]{
                        print(JSON(data).description)
                        
                        success(data)
                    }else{
                        print("======解析失败======")
                        fail(nil)
                    }
                }
                catch let error{
                    let err = error as! MoyaError
                    if let errResponse = err.response {
                        if let data = try? errResponse.mapJSON() as? [String : Any]{
                            let errJson = JSON(data)
                            print(JSON(data))
                            
                            acvitityView.showCustomToast("error:\(errJson["status_code"].stringValue)",
                                title: errJson["message"].stringValue
                            )
                            
                        }else{
                            print("======解析失败======")
                            fail(nil)
                        }
                    }
                }
            case let .failure(error):
                print("===========请求失败==============")
                
                if showAcvitity {
                    acvitityView.hiddenGifLoad()
                    acvitityView.isUserInteractionEnabled = true
                }
                
                fail(error)
            }
        }
    }
}
