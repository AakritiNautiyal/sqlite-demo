//
//  DBManager.swift
//  EmployeeDB
//
//  Created by daffolapmac-136 on 05/05/22.
//

import Foundation
import SQLite3

class DBManager{
    static var shared = DBManager()
    var db: OpaquePointer?
    let fileName = "Employee.sqlite"
    
    init() {
        self.db = initializeDatabase()
        createTable()
    }
    
    func initializeDatabase() -> OpaquePointer? {
        do{
            //Creating database
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(fileName)
            print(fileURL)
            
            //Opening database
            if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
                return db
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error opening table: \(errmsg)")
            }
        } catch{
            print("error while creating file \(error)")
        }
        return nil
    }
    
    func createTable(){
        let query = "CREATE TABLE IF NOT EXISTS Employee (code TEXT PRIMARY KEY, name TEXT, email TEXT, address TEXT, contact TEXT, technology TEXT);"
        var stmt:OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, query, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("table created successfully")
            } else {
                print("table creation failed")
            }
        } else {
            print("preparation for table creation failed")
        }
    }
    
    func insertNewEmployee(emp:Employee) -> Bool{
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Employee (code, name, email, address, contact, technology) VALUES (?,?,?,?,?,?);"
        
        //preparing the query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
            
            //binding the parameters
            sqlite3_bind_text(stmt, 1, (emp.code as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (emp.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (emp.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (emp.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 5, (emp.contact as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 6, (emp.technology as NSString).utf8String, -1, nil)
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("record inserted successfully")
                return true
            } else {
                print("record insertion failed")
            }
        } else {
            print("insertion prep failed")
        }
        return false
    }
    
    func getAllEmployees() -> [Employee]?{
        var employeesList = [Employee]()
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "SELECT * FROM Employee;"
        
        //preparing the query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
            
            while sqlite3_step(stmt) == SQLITE_ROW{
                let code = String(describing: String(cString: sqlite3_column_text(stmt, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(stmt, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(stmt, 2)))
                let address = String(describing: String(cString: sqlite3_column_text(stmt, 3)))
                let contact = String(describing: String(cString: sqlite3_column_text(stmt, 4)))
                let technology = String(describing: String(cString: sqlite3_column_text(stmt, 5)))
                let employee = Employee(code: code, name: name, email: email, address: address, contact: contact, technology: technology)
                employeesList.append(employee)
            }
            return employeesList
        } else {
            print("fetching failed")
        }
        return nil
    }
    
    func getDetails(for empCode:String) -> Employee?{
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "SELECT * FROM Employee WHERE code = '\(empCode)';"
        
        //preparing the query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
            
            while sqlite3_step(stmt) == SQLITE_ROW{
                let code = String(describing: String(cString: sqlite3_column_text(stmt, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(stmt, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(stmt, 2)))
                let address = String(describing: String(cString: sqlite3_column_text(stmt, 3)))
                let contact = String(describing: String(cString: sqlite3_column_text(stmt, 4)))
                let technology = String(describing: String(cString: sqlite3_column_text(stmt, 5)))
                let employee = Employee(code: code, name: name, email: email, address: address, contact: contact, technology: technology)
                return employee
            }
        } else {
            print("fetching failed")
        }
        return nil
    }
    
    func updateDetails(for emp:Employee) -> Bool{
        //creating a statement
        var stmt: OpaquePointer?
        
        //the update query
        let queryString = "UPDATE Employee SET name = '\(emp.name)',  email = '\(emp.email)', address = '\(emp.address)', contact = '\(emp.contact)', technology = '\(emp.technology)' WHERE code = '\(emp.code)';"
        
        //preparing the query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("record updated successfully")
                return true
            } else {
                print("record updation failed")
            }
        } else {
            print("updation prep failed")
        }
        return false
    }
    
    func deleteDetails(for empCode:String) -> Bool{
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "DELETE FROM Employee WHERE code = '\(empCode)';"
        
        //preparing the query
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("record deleted successfully")
                return true
            } else {
                print("record deletion failed")
            }
            
        }else {
            print("deletion prep failed")
        }
        return false
    }
}
