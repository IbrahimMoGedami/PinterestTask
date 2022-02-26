//
//  Target.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 24/02/2022.
//

import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain
    case getWithParameters(parameters: [String: Any])
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

struct HeaderType{
    var header: HTTPHeaders{
        get{
            ["Authorization": "token",
             "contentType": "application/json"]
        }
    }
}

struct URLs {
    static let baseURL = "https://mocki.io/"
    static let productURL = "v1/66582140-ff28-4ab4-a9f7-adaa2e494417"
}

extension Dictionary where Key == String, Value == String {
    func toHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        for (key, value) in self  {
            headers.add(name: key, value: value)
        }
        return headers
    }
}
