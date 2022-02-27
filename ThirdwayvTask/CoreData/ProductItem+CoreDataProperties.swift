//
//  ProductItem+CoreDataProperties.swift
//  
//
//  Created by Ibrahim Mo Gedami on 26/02/2022.
//
//

import Foundation
import CoreData


extension ProductItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
        return NSFetchRequest<ProductItem>(entityName: "ProductItem")
    }

    @NSManaged public var descrption: String?
    @NSManaged public var price: Int32
    @NSManaged public var productID: Int64
    @NSManaged public var image: NSObject?
    @NSManaged public var myProduct: NSSet?

}

// MARK: Generated accessors for myProduct
extension ProductItem {

    @objc(addMyProductObject:)
    @NSManaged public func addToMyProduct(_ value: ProductItem)

    @objc(removeMyProductObject:)
    @NSManaged public func removeFromMyProduct(_ value: ProductItem)

    @objc(addMyProduct:)
    @NSManaged public func addToMyProduct(_ values: NSSet)

    @objc(removeMyProduct:)
    @NSManaged public func removeFromMyProduct(_ values: NSSet)

}
