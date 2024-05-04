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
                    var statusCode = response.statusCode
                    if(statusCode == 200){
                        var data = response.data
                        
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
}
