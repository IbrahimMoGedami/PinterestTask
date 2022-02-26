//
//  ProductImage+CoreDataProperties.swift
//  
//
//  Created by Ibrahim Mo Gedami on 26/02/2022.
//
//

import Foundation
import CoreData


extension ProductImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductImage> {
        return NSFetchRequest<ProductImage>(entityName: "ProductImage")
    }

    @NSManaged public var height: Int32
    @NSManaged public var width: Int32
    @NSManaged public var url: String?
    @NSManaged public var product: ProductItem?

}
