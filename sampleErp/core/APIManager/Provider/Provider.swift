//
//  Provider.swift
//  sampleErp
//
//  Created by Karthikeyan M on 04/05/24.
//

import Foundation
import Moya


enum APIProviderType {
    case loginFlow
    case submitLogin(method: String, password : String, identifier : String, password_identifier: String, flow : String)
}

extension APIProviderType : TargetType{
    
    var baseURL: URL {
        return URL(string: "https://tender-chandrasekhar-py8rlvko0s.projects.oryapis.com")!
    }
    
    var path: String {
        switch self{
        case .loginFlow:
//            return "/self-service/login/api?refresh=true&aal=&return_session_token_exchange_code=true&return_to=&via="
            return "/self-service/login/api"
        case .submitLogin(method: _, password: _, identifier: _, password_identifier: _, flow: _):
            return "/self-service/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginFlow:
            return .get
        case .submitLogin(_,_,_,_,_):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .loginFlow:
            return Data()
        default:
            return Data()
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .loginFlow:
            return ["refresh":true,"return_session_token_exchange_code":true]
        case .submitLogin(method: let method, password: let password, identifier: let identifier, password_identifier: let password_identifier, flow: _):
            return [
                "method" : method,
                "password" : password,
                "identifier" : identifier,
                "password_identifier" : password_identifier
            ]
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .loginFlow:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
        case .submitLogin(_,_,_,_,flow: let flow):
           //return .requestCompositeData(bodydata: parameters,  urlParameters: ["flow" : flow])
//            return .requestCompositeData(bodyData: parameters, urlParameters: ["flow" : flow])
            
            return .requestCompositeParameters(bodyParameters: parameters ?? [:], bodyEncoding: URLEncoding.httpBody, urlParameters: ["flow" : flow])
//        default:
//            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .loginFlow:
            return ["Authorization": "Bearer qZNu.jfSiUJhc.ufCn-R6l3sWj"]
        case .submitLogin(method: _, password: _, identifier: _, password_identifier: _, flow: _):
            return ["Content-Type":"application/x-www-form-urlencoded", "Accept":"application/json"]
        }
    }
}
