//
//  AppFlow.swift
//  sampleErp
//
//  Created by Karthikeyan M on 03/05/24.
//

import UIKit

fileprivate enum Storyboard : String{
    case main       = "Main"
//    case dashboard  = "Dashboard"
}

fileprivate extension UIStoryboard{
    static func  loadFromMain(_ identifier : String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
//    static func  loadFromDashBoard(_ identifier : String) -> UIViewController {
//        return load(from: .dashboard, identifier: identifier)
//    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController{
        let uistroryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uistroryboard.instantiateViewController(withIdentifier: identifier)
    }
}


extension UIStoryboard{
    // login as Page
    class func loadLoginPage() -> ViewController{
        return loadFromMain("ViewController") as! ViewController
    }
    
    class func loadRegisterPage() -> RegistrationViewController{
        return loadFromMain("RegistrationViewController") as! RegistrationViewController
    }
}
