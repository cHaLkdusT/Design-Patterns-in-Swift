//
//  PoolItem.swift
//  ObjectPool
//
//  Created by jlundang on 09/06/2016.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

@objc protocol PoolItem {
    var canReuse: Bool { get }
}