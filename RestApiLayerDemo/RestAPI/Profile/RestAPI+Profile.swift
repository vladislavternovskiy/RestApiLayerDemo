//
//  RestAPI+Profile.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
//

import Moya

extension RestAPI {
    
    enum Profile {
        case getProfile
        case editProfile(user: User)
    }
}

extension RestAPI.Profile {
    
    var baseURL: URL {
        return Endpoint.baseURL
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return Endpoint.Profile.getProfile
        case .editProfile:
            return Endpoint.Profile.editProfile
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile:
            return .get
        case .editProfile:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .editProfile(let user):
            return try? user.encodeToDictionary()
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .editProfile:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = accessToken, token.isEmpty == false else {
            return nil
        }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "token")
    }
    
    var url: String {
        return "\(baseURL)\(path)"
    }
}
