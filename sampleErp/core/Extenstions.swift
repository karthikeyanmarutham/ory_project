//
//  Extenstions.swift
//  sampleErp
//
//  Created by Karthikeyan M on 03/05/24.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
