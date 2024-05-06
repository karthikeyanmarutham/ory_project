//
//  ViewController.swift
//  sampleErp
//
//  Created by Karthikeyan M on 03/05/24.
//

import UIKit
import FloatingLableTextField
import ProgressHUD

class ViewController: UIViewController {

    
    @IBOutlet weak var txtUserName: FloatigLableTextField!
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var txtPassword: FloatigLableTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        //view setup
        setup()
        super.viewDidLoad()
    }
    
    func setup(){
        self.hideKeyboardWhenTappedAround()
        
        self.txtUserName.placeholder = "Email Id"
        self.txtPassword.placeholder = "Password"
        self.btnLogin.addTarget(self, action: #selector(onLogin(_:)), for: .touchUpInside)
        self.btnRegister.addTarget(self, action: #selector(onRegister(_:)), for: .touchUpInside)
        self.vwBase.layer.cornerRadius = 8.0
        self.vwBase.layer.masksToBounds = true
        
        apiCall()
    }
    
    func apiCall(){
        ProgressHUD.animate("loading..", interaction: false)
        APIManager.sharedInstance.getLoginFlowCreate { loginFlowModel in
            self.appDelegate.flowID = loginFlowModel?.id
            ProgressHUD.succeed()
        } onFailed: { error in
            ProgressHUD.failed()
            SweetAlert().showAlert("Alert", subTitle: "Error", style: .warning, buttonTitle:  "Ok", buttonColor: .label, otherButtonTitle: "Retry", otherButtonColor: .orange) { isOtherButton in
                if(isOtherButton){
                    self.apiCall()
                }
            }
        }
    }

    // submit login request
    @objc func onLogin(_ sender: UIButton){
        if(self.txtUserName.hasText && self.txtPassword.hasText){
            let username = self.txtUserName.text ?? ""
            let password = self.txtPassword.text ?? ""
            
            let flow = self.appDelegate.flowID ?? ""
            
            APIManager.sharedInstance.postSubmitLoginFlow(withFlow: flow, withPassword: password, withIdentifier: username) { loginmodel in
                _ = SweetAlert().showAlert("Login Success", subTitle: "flow ID is \(loginmodel?.id ?? "")", style: .warning, buttonTitle: "Okay")
            } onFailed: { error in
                _ = SweetAlert().showAlert("Alert", subTitle: "Something Went to Wrong!!", style: .error, buttonTitle: "Okay")
            }
        }else{
            _ = SweetAlert().showAlert("Alert", subTitle: "Email and Password is must", style: .warning, buttonTitle: "Okay")
        }
    }
    
    @objc func onRegister(_ sender: UIButton){
        let vc = UIStoryboard.loadRegisterPage()
        self.present(vc,animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
