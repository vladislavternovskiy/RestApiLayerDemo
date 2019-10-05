//
//  RestAPI.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
//

import Foundation

enum RestAPI {
    
    case profile(ProfileSpecification)
}

extension RestAPI {
    
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://api.test.one")!
}
