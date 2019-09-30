//
//  TargetType.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
//

import Moya

extension TargetType {
    
    var url: String {
        return "\(baseURL)\(path)"
    }
}
