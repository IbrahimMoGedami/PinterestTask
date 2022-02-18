//
//  ProductInteractor.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation

class ProductInteractor{
    
    func productApi(completion : @escaping ( Product? ,Error?)->()){
        
        ApiService.shared.prasingJson { (product: Product?, error: Error?) in
            if let error = error {
                completion(nil ,error)
            }else{
                guard let productModel = product else { return }
                completion(productModel ,nil)
            }
        }
    }
}
