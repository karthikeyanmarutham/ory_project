//
//  APImanager.swift
//  sampleErp
//
//  Created by Karthikeyan M on 04/05/24.
//

import Foundation
import Moya

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    func getLoginFlowCreate(onSuccess: @escaping(LoginFlowModel?) -> Void, onFailed: @escaping([String : Any]) -> Void){
        
        let provider = MoyaProvider<APIProviderType>()
        
        provider.request(.loginFlow) { result in
            result.map { responce in
                switch result{
                case .success(let response):
                    let statusCode = response.statusCode
                    if(statusCode == 200){
                        let data = response.data
                        do {
                            let loginFlowModel = try? JSONDecoder().decode(LoginFlowModel.self, from: data)
                            onSuccess(loginFlowModel)
                        } catch let error {
                            onFailed(["error" : "Something went to wrong!!"])
                        }
                        
                    }else{
                        onFailed(["error" : "Something went to wrong!!"])
                    }
                    break
                case .failure(let error):
                    onFailed(["error" : error.response?.data ?? {}])
                    break
                }
            }
        }
    }
    
    func postSubmitLoginFlow(withFlow flow : String,withPassword password : String,withIdentifier identifier : String, onSuccess: @escaping(LoginModel?) -> Void, onFailed: @escaping([String : Any]) -> Void){
        
        let provider = MoyaProvider<APIProviderType>()
        
        provider.request(.submitLogin(method: "password", password: password, identifier: identifier, password_identifier: "Email", flow: flow)) { result in
            result.map { res in
                switch result {
                    case .success(_):
                        let status = res.statusCode
                        if(status == 200){
                            let data = res.data
                            do {
                                let loginModel = try? JSONDecoder().decode(LoginModel.self, from: data)
                                onSuccess(loginModel)
                            } catch let error {
                                onFailed(["error" : "Something went to wrong!!"])
                            }
                        } else {
                            onFailed(["error" : "Something went to wrong!!"])
                        }
                    break
                case .failure(let error):
                    onFailed(["error" : error.response?.data ?? {}])
                    break
                }
            }
        }
    }
}
