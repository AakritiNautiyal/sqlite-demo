//
//  TechnologyListVC.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 08/05/22.
//

import UIKit

class TechnologyListVC: UIViewController {
    
    var techList = [String]()
    
    @IBOutlet private weak var techTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        techTableView.register(UINib(nibName: "TechTableViewCell", bundle: nil), forCellReuseIdentifier: "techCell")
        techList = DBManager.shared.fetchTechnologies()
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TechnologyListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return techList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "techCell") as! TechTableViewCell
        cell.textLabel?.text = techList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
