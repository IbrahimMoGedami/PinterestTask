//
//  MainProductInterActor.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 24/02/2022.
//

import Foundation

protocol MainProductProtocol {
    func getProduct(completion: @escaping(Product?, Error?) -> Void)
}

class MainProductInterActor: APIServices<MainProductNetwork>, MainProductProtocol {

    func getProduct(completion: @escaping (Product?, Error?) -> Void) {
        self.fetchData(target: .getProducts, responseClass: Product.self) { (data) in
            switch data{
            case .success(let product):
                completion(product, nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
