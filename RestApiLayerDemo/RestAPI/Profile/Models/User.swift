//
//  User.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
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
