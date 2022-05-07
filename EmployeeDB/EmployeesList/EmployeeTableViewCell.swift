//
//  EmployeeTableViewCell.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 06/05/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet private weak var empName: UILabel!
    @IBOutlet private weak var empCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(employee: Employee){
        empName.text = employee.name
        empCode.text = employee.code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
