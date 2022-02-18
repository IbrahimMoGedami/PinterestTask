//
//  Api.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation

class ApiService {
    
    private init(){ }
    
    static let shared = ApiService()
    
    func prasingJson <T : Codable>(completion : @escaping (T? , Error?)->()) {
        guard let path = Bundle.main.path(forResource: "products", ofType: "json") else { return  }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(result , nil)
        } catch  {
            print("Error : \(error)")
            completion(nil,error)
        }
    }
    
}
