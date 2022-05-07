//
//  AddEmployeeVC.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 05/05/22.
//

import UIKit

enum Operation {
    case view
    case add
    case update
}

class EmployeeViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet private weak var empCodeTextField: UITextField!
    @IBOutlet private weak var empNameTextField: UITextField!
    @IBOutlet private weak var empEmailTextField: UITextField!
    @IBOutlet private weak var empAddressTextField: UITextField!
    @IBOutlet private weak var empContactNoTextField: UITextField!
    @IBOutlet private weak var empTechnologyTextField: UITextField!
    @IBOutlet private weak var updateDeleteStackView: UIStackView!
    @IBOutlet private weak var createEmployeeButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var headerLabel: UILabel!
    
    var employee:Employee?
    var operation:Operation = .add
    var activetextField: UITextField?
    
    
    //MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bar = UIToolbar()
        let doneBar = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        bar.items = [doneBar]
        bar.sizeToFit()
        empContactNoTextField.inputAccessoryView = bar
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    //MARK:- Selector methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        mainScrollView.contentInset = .zero
        mainScrollView.scrollIndicatorInsets = .zero
    }
    
    @objc func doneTapped(){
        empTechnologyTextField.becomeFirstResponder()
    }
    
    //MARK:- Setup methods
    
    func setup(){
        switch operation {
        
        case .add:
            setupForAdd()
            break;
            
        case .view:
            setupForView()
            break
            
        case .update:
            setupForUpdate()
            break
        }
    }
    
    func setupForAdd(){
        headerLabel.text = "Add details"
        updateDeleteStackView.isHidden = true
        createEmployeeButton.isHidden = false
    }
    
    func setupForView(){
        headerLabel.text = "Employee's Details"
        updateDeleteStackView.isHidden = false
        createEmployeeButton.isHidden = true
        fillDetails()
        setInteractionsOnTextFields(isEnabled: false)
    }
    
    func setupForUpdate(){
        headerLabel.text = "Update Details"
        deleteButton.isHidden = true
        setInteractionsOnTextFields(isEnabled: true)
    }
    
    func getEmployeeFromDetails() -> Employee?{
        if let code = empCodeTextField.text, code != "",
           let name = empNameTextField.text, name != "",
           let email = empEmailTextField.text, email != "",
           let address = empAddressTextField.text, address != "",
           let contact =  empContactNoTextField.text, contact != "",
           let technology = empTechnologyTextField.text, technology != ""{
            let newEmployee = Employee(code: code, name: name, email: email, address: address, contact: contact, technology: technology)
            return newEmployee
        }
        return nil
    }
    
    //MARK:- IBActions
    
    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDetails(_ sender: Any) {
        if let newEmployee = getEmployeeFromDetails(){
            if DBManager.shared.insertNewEmployee(emp: newEmployee){
                showAlert(message: "Insertion successful") {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                showAlert(with: "Insertion failed")
            }
        } else {
            showAlert(with: "Please fill all details")
        }
    }
   
    @IBAction func updateDEtails(_ sender: Any) {
        
        if operation == .view{
            operation = .update
            setupForUpdate()
        }else if operation == .update{
            if let newEmployee = getEmployeeFromDetails(){
                if DBManager.shared.updateDetails(for: newEmployee){
                    showAlert(message: "Details Updated Successfully") {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    showAlert(with: "Updation failed")
                }
            }
        }
    }
    
    @IBAction func deleteEmployee(_ sender: Any) {
        if let employeeToBeDeleted = employee{
            if DBManager.shared.deleteDetails(for: employeeToBeDeleted.code){
                showAlert(message: "Employee deleted successfully") {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                showAlert(with: "Deletion failed")
            }
        }
    }
    
    //Methd to fill all text fields in case of update and view details
    func fillDetails(){
        if let emp = employee{
            empCodeTextField.text = emp.code
            empNameTextField.text = emp.name
            empEmailTextField.text = emp.email
            empAddressTextField.text = emp.address
            empContactNoTextField.text = emp.contact
            empTechnologyTextField.text = emp.technology
        }
    }
    
    //Setting user interaction for update and view case
    func setInteractionsOnTextFields(isEnabled:Bool){
        //For updating the fields
        empCodeTextField.isUserInteractionEnabled = false
        empNameTextField.isUserInteractionEnabled = isEnabled
        empEmailTextField.isUserInteractionEnabled = isEnabled
        empAddressTextField.isUserInteractionEnabled = isEnabled
        empContactNoTextField.isUserInteractionEnabled = isEnabled
        empTechnologyTextField.isUserInteractionEnabled = isEnabled
    }
    
    
    
}

extension EmployeeViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = textField.tag + 1
        
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activetextField = textField
        return true
    }
}
