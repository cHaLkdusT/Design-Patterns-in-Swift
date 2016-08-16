//
//  Employees.swift
//  Adapter
//
//  Created by jlundang on 01/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

struct Employee {
    var name: String
    var title: String
}

protocol EmployeeDataSource {
    var employees: [Employee] { get }
    func searchByName(name: String) -> [Employee]
    func searchByTitle(title: String) -> [Employee]
}