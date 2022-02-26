//
//  MainProductNetwork.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 24/02/2022.
//

import Foundation
import Alamofire

enum MainProductNetwork {
    case getProducts
    
}

extension MainProductNetwork: TargetType {
    var path: String {
        switch self {
        case .getProducts:
            return URLs.productURL
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
    var base: String {
        switch self {
        default:
            return URLs.baseURL
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        }
    }
    
}
