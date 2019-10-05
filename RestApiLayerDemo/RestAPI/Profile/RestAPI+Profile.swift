//
//  ProfileSpecification.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
//

import Moya

enum ProfileSpecification {
    
    enum HTTPResource {
        static let getProfile = "/getProfile"
        static let editProfile = "/editProfile"
    }
    
    case getProfile
    case editProfile(user: User)
}

extension ProfileSpecification: RequestSpecification {
    typealias ModelDTO = User
    
    var absoluteURLString: String {
        return "\(baseURL)\(path)"
    }
    
    var baseURL: URL {
        return RestAPI.baseURL
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return HTTPResource.getProfile
        case .editProfile:
            return HTTPResource.editProfile
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
    
    var parameters: [String: Any] {
        switch self {
        case .editProfile(let user):
            return (try? user.encodeToDictionary()) ?? [:]
        default:
            return [:]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .editProfile:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        guard let token = accessToken, token.isEmpty == false else {
            return nil
        }
        return ["Authorization": "Bearer \(token)"]
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "token")
    }
}
