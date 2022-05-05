//
//  Employee.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 05/05/22.
//

import Foundation

class Employee {
    
    let code:String
    let name:String
    let email:String
    let address:String
    let contact:String
    let technology:String
    
    
    init(code:String, name:String, email:String, address:String, contact:String, technology:String){
        self.code = code
        self.name = name
        self.email = email
        self.address = address
        self.contact = contact
        self.technology = technology
    }
}
