//
//  ProductModel.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    var data: [ProductData]
}

// MARK: - Datum
struct ProductData: Codable {
    var id: Int?
    var productDescription: String?
    var image: Image?
    var price: Int?
    
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productDescription = "productDescription"
        case image = "image"
        case price = "price"
    }
    
    init(){}

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        do{
//            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
//        } catch{
//
//        }
//        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)!
////        image = try values.decodeIfPresent(Image.self, forKey: .image)
//        price = try values.decodeIfPresent(Int.self, forKey: .price) ?? 0
//
//    }
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int?
    let url: String?
}


