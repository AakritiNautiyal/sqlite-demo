//
//  UIViewController.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 06/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String = "Alert", message: String, button : String = "OK", completionHandler : @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            completionHandler()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
