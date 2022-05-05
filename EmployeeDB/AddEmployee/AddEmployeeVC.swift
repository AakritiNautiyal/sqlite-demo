//
//  AddEmployeeVC.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 05/05/22.
//

import UIKit

class AddEmployeeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDetails(_ sender: Any) {
    }
    
}
