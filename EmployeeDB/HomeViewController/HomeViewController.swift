//
//  ViewController.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 05/05/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
    }

    @IBAction func viewEmployeeDetail(_ sender: Any) {
    }
    
    @IBAction func addNewEmployee(_ sender: Any) {
        let addNewEmployeeVC = AddEmployeeVC(nibName: "AddEmployeeVC", bundle: nil)
        self.navigationController?.pushViewController(addNewEmployeeVC, animated: true)

    }
    
    @IBAction func updateEmployeeDetails(_ sender: Any) {
    }
    
    @IBAction func removeEmployee(_ sender: Any) {
    }
    
    func setGradientBackground() {
        let colorTop = UIColor(red: 247.0/255.0, green: 187.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 224.0/255.0, green: 94.0/255.0, blue: 137.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

