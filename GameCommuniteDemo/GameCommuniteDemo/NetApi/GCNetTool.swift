//
//  MXTNetTool.swift
//  mingxint
//
//  Created by payTokens on 2019/4/18.
//  Copyright © 2019 放. All rights reserved.
//

import Foundation
import Moya

#if DEBUG
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#else
fileprivate let baseUrl = "http://playtest.uioj.com/api/"
#endif

enum GCNetApi {
    case register(prama: [String: String])

}

extension GCNetApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {

        case .register:
            return "users"
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
            /**
             * 所有的说说
             */
        case let .register(prama):
            return .requestParameters(parameters: prama, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        if let token = UserDefaults.standard.value(forKey: "loadToken") as? String{
            print("token:\(token)")
            return ["token_name" : token]
            
        }else {
            return [:]
        }
    }
}


class GCNetTool {
    static func requestData<T: TargetType>(target: T, showAcvitity: Bool = false, success: @escaping (_ responseData: [String : Any]) ->(), fail: @escaping (_ error: MoyaError?)->()){
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
                    print(data)
                    let status = data["status"] as! Int
                    
                    guard status == 200 else {
                        if status == 2000{//异地登录或者没有登录
                            kWindow?.makeToast("请登录")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jump"), object: "login")
                        }
                        fail(nil)
                        print("状态码不对:\(status)")
                        return}
                    
                    
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
