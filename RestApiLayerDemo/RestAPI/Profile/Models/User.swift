//
//  User.swift
//  LeroyMerlin
//
//  Created by Oleksii Huralnyk on 8/14/17.
//  Copyright © 2017 NullGravity. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var firstName: String
    var lastName: String
    var email: String?
    var phone: String?
    var customerNumber: String
    let subscribe: Bool
}
