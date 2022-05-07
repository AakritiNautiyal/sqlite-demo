//
//  EmployeesListVC.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 06/05/22.
//

import UIKit

class EmployeesListVC: UIViewController {

    @IBOutlet private weak var employeeTableView: UITableView!
    var employeesList = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployees()
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addNewEmployee(_ sender: Any) {
        let addNewEmployeeVC = EmployeeViewController(nibName: "EmployeeViewController", bundle: nil)
        addNewEmployeeVC.operation = .add
        self.navigationController?.pushViewController(addNewEmployeeVC, animated: true)
    }
    
    func fetchEmployees(){
        if let employees = DBManager.shared.getAllEmployees(){
            if employees.count == 0{
                let alert = UIAlertController(title: "Alert", message: "No employees present", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                employeesList = employees
                employeeTableView.reloadData()
            }
            
        } else {
            let alert = UIAlertController(title: "Alert", message: "Loading failed", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension EmployeesListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmpCell") as! EmployeeTableViewCell
        cell.setup(employee: employeesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewEmployeeVC = EmployeeViewController(nibName: "EmployeeViewController", bundle: nil)
        viewEmployeeVC.operation = .view
        viewEmployeeVC.employee = employeesList[indexPath.row]
        self.navigationController?.pushViewController(viewEmployeeVC, animated: true)
        
    }
}
