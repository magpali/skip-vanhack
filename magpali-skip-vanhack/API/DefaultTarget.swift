//
//  DefaultTarget.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift
import Moya

enum DefaultTarget {
    case listCousine()
    case listStore(cousineId: Int)
    case listProducts(storeId: Int)
}

extension DefaultTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://api-vanhack-event-sp.azurewebsites.net/api/v1")!
    }
    
    var path: String {
        switch self {
        case .listCousine:
            return "Cousine"
        case .listStore(let cousineId):
            return "Cousine/\(cousineId)/stores"
        case .listProducts(let storeId):
            return "Store/\(storeId)/products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listCousine, .listStore, .listProducts:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestParameters(parameters: self.parameters ?? [:],
                                      encoding: self.parameterEncoding)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .listCousine, .listStore, .listProducts:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}
