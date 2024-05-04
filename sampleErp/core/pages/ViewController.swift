//
//  ViewController.swift
//  sampleErp
//
//  Created by Karthikeyan M on 03/05/24.
//

import UIKit
import FloatingLableTextField

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
    }

    @objc func onLogin(_ sender: UIButton){
        APIManager.sharedInstance.getLoginFlowCreate { loginFlowModel in
            
            print(loginFlowModel?.id ?? "nil")
            
            _ = SweetAlert().showAlert("Alert", subTitle: "Login Flow Succeed", style: .success, buttonTitle: "Ok", action: { (nbb) in
    
            })
        } onFailed: { error in
            _ = SweetAlert().showAlert("Alert", subTitle: "Error", style: .warning, buttonTitle: "Ok", action: { (nbb) in
    
            })
        }

    }
    
    @objc func onRegister(_ sender: UIButton){
        let vc = UIStoryboard.loadRegisterPage()
        self.present(vc,animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
