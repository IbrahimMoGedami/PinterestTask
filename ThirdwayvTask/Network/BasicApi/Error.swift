//
//  Error.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 24/02/2022.
//

import Foundation

enum Errors: Error {
    case notConnectedToInternet
    
    var errorDescription : String{
        switch self {
        case .notConnectedToInternet:
            return "No internet Connection , please try again!"
        }
    }
    
}
