//
//  FindEmployeeVC.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 08/05/22.
//

import UIKit

class FindEmployeeVC: UIViewController {

    @IBOutlet private weak var empCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK:- IBActions
    
    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func search(_ sender: Any) {
        if let code = empCodeTextField.text, code != ""{
            if let emp = DBManager.shared.getDetails(for: code){
                let employeeVC = EmployeeViewController(nibName: "EmployeeViewController", bundle: nil)
                employeeVC.employee = emp
                employeeVC.operation = .view
                navigationController?.pushViewController(employeeVC, animated: true)
            } else {
                showAlert(with: "Employee with code '\(code)' not found")
            }
        } else {
            showAlert(with: "Please enter a valid employee code")
        }
    }
}


extension FindEmployeeVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
