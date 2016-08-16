//
//  Adapter.swift
//  Adapter
//
//  Created by jlundang on 04/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

class NewCoDirectoryAdapter: EmployeeDataSource {
    private let directory: NewCoDirectory
    
    init() {
        directory = NewCoDirectory()
    }
    
    var employees: [Employee] {
        return directory.getStaff().values.map({ sv -> Employee in
            return Employee(name: sv.getName(), title: sv.getJob())
        })
    }
    
    func searchByName(name: String) -> [Employee] {
        return createEmployees(filter: { sv -> Bool in
            return sv.getName().rangeOfString(name) != nil
        })
    }
    
    func searchByTitle(title: String) -> [Employee] {
        return createEmployees(filter: { sv -> Bool in
            return sv.getJob().rangeOfString(title) != nil
        })
    }
    
    private func createEmployees(filter filterClosure: (NewCoStaffMember) -> Bool)
        -> [Employee] {
        return directory.getStaff().values.filter(filterClosure)
            .map({ entry -> Employee in
                return Employee(name: entry.getName(), title: entry.getJob())
            })
    }
}

//extension NewCoDirectory : EmployeeDataSource {
//    var employees: [Employee] {
//        return getStaff().values.map({ sv -> Employee in
//            return Employee(name: sv.getName(), title: sv.getJob())
//        })
//    }
//    
//    func searchByName(name: String) -> [Employee] {
//        return createEmployees(filter: { sv -> Bool in
//            return sv.getName().rangeOfString(name) != nil
//        })
//    }
//    
//    func searchByTitle(title: String) -> [Employee] {
//        return createEmployees(filter: { sv -> Bool in
//            return sv.getJob().rangeOfString(title) != nil
//        })
//    }
//    
//    private func createEmployees(filter filterClosure: (NewCoStaffMember) -> Bool)
//        -> [Employee] {
//        return getStaff().values.filter(filterClosure)
//            .map({ entry -> Employee in
//                return Employee(name: entry.getName(), title: entry.getJob())
//            })
//    }
//}