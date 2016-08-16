//
//  EmployeeSearch.swift
//  Adapter
//
//  Created by jlundang on 01/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class SearchTool {
    enum SearchType {
        case Name
        case Title
    }
    
    private let sources: [EmployeeDataSource]
    
    init(dataSources: EmployeeDataSource...) {
        self.sources = dataSources
    }
    
    var employees: [Employee] {
        var results = [Employee]()
        for source in sources {
            results += source.employees
        }
        return results
    }
    
    func search(text: String, type: SearchType) -> [Employee] {
        var results = [Employee]()
        
        for source in sources {
            results += type == .Name ? source.searchByName(text)
                : source.searchByTitle(text)
        }
        
        return results
    }
}