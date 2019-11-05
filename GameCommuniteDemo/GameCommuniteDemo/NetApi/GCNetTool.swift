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
    case getUserInfo(prama: [String: String]) //获取用户信息
    //TODO: communite
    case communiteList//社区列表
    case createCommunite(prama: [String: String])//创建社区
    case joinCommunite(prama: String)//加入社区
    case exitCommunite(prama: [String: String])//退出社区
    case communiteDetail(prama: String)//社区详情
    case topicList(prama: [String : String])//话题列表
    case postTopic(prama: [String: String])//发布话题
    case topicDetail(prama: String)//话题详情
    case topicTapZan(prama: String)//话题点赞
    case topicCancelZan(prama: String)//话题取消点赞
    //TODO: updateImg
    case updateImg(prama: [String : String], images: [UIImage])//上传图片
    
    //TODO: goods
    case goodsCate//商品分类
    case goodsList(prama: String)//商品列表
    case goodsDetail(prama: String)//商品详情
    case goodsPost(prama: [String : Any])//商品发布
    case goodsDown(prama: String)//商品下架
    case goodsReEdit(id: String, prama: [String : String])//商品重新编辑
    
    //TODO: pay
    case createOrder(prama: [String: Any])//创建订单
    case orderList([String : String])//订单列表
    case orderPay([String : Int])//支付订单
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
        case .getUserInfo:
            return "user"
            
        //TODO: communite
        case .communiteList:
            return "communities"
        case .createCommunite:
            return "communities"
        case let .joinCommunite(communiteId):
            return "community/members/\(communiteId)"
        case .exitCommunite:
            return "communities"
        case let .communiteDetail(communiteId):
            return "communities/\(communiteId)"
        case .topicList:
            return "topics"
        case .postTopic:
            return "topics"
        case let .topicDetail(topicId):
            return "topics/\(topicId)"
        case let .topicTapZan(topicId):
            return "topic/praises/\(topicId)"
        case let .topicCancelZan(topicId):
            return "topic/praises/\(topicId)"
            
        //TODO: updateImg
        case .updateImg:
            return "images"
            
        //TODO: goods
        case .goodsCate: //商品分类
            return "ornamentCategories"
        case .goodsList://商品列表
            return "ornaments"
        case let .goodsDetail(prama)://商品详情
            return "ornaments/\(prama))"
        case .goodsPost: //商品发布
            return "ornaments"
        case let .goodsDown(prama)://商品下架
            return "ornaments/\(prama)/down"
        case let .goodsReEdit(id, _)://商品重新编辑
            return "ornaments/\(id)"
            
         //TODO: pay
        case .createOrder://创建订单
            return "orders"
        case .orderList://订单列表
            return "orders"
        case .orderPay://支付订单
            return "payments"
        }
    }
    
    var method: Moya.Method {
        
        switch self{
            
        case .communiteList, .topicList, .getUserInfo, .communiteDetail, .topicDetail, .goodsCate, .goodsList, .goodsDetail, .orderList:
            return .get
        case .topicCancelZan:
            return .delete
        case .goodsReEdit:
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
        case let .getUserInfo(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
            
        //TODO: communite
        case  .communiteList, .communiteDetail:
            return .requestPlain
        case let .createCommunite(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case  .joinCommunite:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case let .exitCommunite(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .postTopic(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .topicList(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .topicDetail:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .topicTapZan, .topicCancelZan:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
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
            
        //TODO: goods
        case .goodsCate: //商品分类
            return .requestPlain
        case .goodsList://商品列表
            return .requestPlain
        case .goodsDetail://商品详情
            return .requestPlain
        case let .goodsPost(prama): //商品发布
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case .goodsDown://商品下架
            return .requestPlain
        case let .goodsReEdit(_, prama)://商品重新编辑
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        
        //TODO: pay
        case let .createOrder(prama)://创建订单
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .orderList(prama)://订单列表
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .orderPay(prama)://支付订单
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let keychain = Keychain(service: "access_token")
        if let token = keychain["header"] {
            print("token:\(token)")
            return ["Authorization" : token]
//        }
//        if let token = UserDefaults.standard.value(forKey: "access_token") as? String{
//            print("token:\(token)")
//            return ["Authorization" : token]
            
        }else {
            return [:]
        }
    }
}


class GCNetTool {
    
    static func requestData<T: TargetType>(target: T, controller: UIViewController? = nil, showAcvitity: Bool = false, isTapAble: Bool = false, success: @escaping (_ responseData: [String : Any]) ->(), fail: @escaping (_ error: MoyaError?)->()){
        
        JYLog("请求接口为: \(target.path)")
        
        var acvitityView: UIView!
        if controller != nil {
            acvitityView = controller?.view
        }else {
            acvitityView = kWindow
        }
        
        //设置请求发起者
        let provider = MoyaProvider<T>()
        
        //是否隐藏菊花
        if showAcvitity {
            acvitityView.makeToastActivity(.center)
            acvitityView.isUserInteractionEnabled = isTapAble
        }
        
        //发起请求
        provider.request(target) { (result) in
            switch result{
                
            //请求成功
            case let .success(response):
 
                print("===========请求成功===========")
                if showAcvitity {
                    acvitityView.hideToastActivity()
                    acvitityView.isUserInteractionEnabled = true
                }
                
               
                
//                if response.statusCode != 200 {
//                    if let data = try? response.mapJSON() as? [String : Any]{
//                        let error = data["message"] as! String
//                        print(error)
//                        return
//                    }
//                }
                
                //解析json数据
                if let data = try? response.mapJSON() as? [String : Any]{
                    print(JSON(data).description)
                    
                    success(data)
                }else{
                    print("======解析失败======")
                    fail(nil)
                }
            case let .failure(error):
                print("===========请求失败==============")
                
                if showAcvitity {
                    acvitityView.hideToastActivity()
                    acvitityView.isUserInteractionEnabled = true
                }
                
                fail(error)
            }
        }
    }
}
