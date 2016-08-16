//
//  main.swift
//  Adapter
//
//  Created by jlundang on 01/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

let search = SearchTool(dataSources: SalesDataSource(),
                        DevelopmentDataSource(),
                        NewCoDirectoryAdapter())

print("--List--")
for e in search.employees {
    print("Name: \(e.name)")
}

print("--Search--")
for e in search.search("VP", type: .Title) {
    print("Name: \(e.name), Title: \(e.title)")
}