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

#if DEBUG
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#else
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#endif

enum GCNetApi {
    case register(prama: [String: String])
    case sendCode(prama: [String: String])
    case getUserInfo(prama: [String: String])
}

extension GCNetApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        
        switch self {
        case .register:
            return "users"
        case .sendCode:
            return "verificationCodes"
        case .getUserInfo:
            return "user"
        }
    }
    
    var method: Moya.Method {

       return .post

    }
    
    var sampleData: Data {
        return Data(base64Encoded: "just for test")!
    }
    
    var task: Task {
        switch self {
        case let .register(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .sendCode(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        case let .getUserInfo(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        if let token = UserDefaults.standard.value(forKey: "access_token") as? String{
            print("token:\(token)")
            return ["Authorization" : token]
            
        }else {
            return [:]
        }
    }
}


class GCNetTool {
    static func requestData<T: TargetType>(target: T, showAcvitity: Bool = false, success: @escaping (_ responseData: [String : Any]) ->(), fail: @escaping (_ error: MoyaError?)->()){
        
        JYLog("请求接口为: \(target.path)")
        
        //设置请求发起者
        let provider = MoyaProvider<T>()
        
        //是否隐藏菊花
        if showAcvitity {
            kWindow?.makeToastActivity(.center)
        }

        //发起请求
        provider.request(target) { (result) in
            switch result{
                
            //请求成功
            case let .success(response):
                print("===========请求成功===========")
                if showAcvitity {
                     kWindow?.hideToastActivity()
                }
               
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
                    kWindow?.hideToastActivity()
                }
                
                print(error)
                
                fail(error)
            }
        }
    }
}
