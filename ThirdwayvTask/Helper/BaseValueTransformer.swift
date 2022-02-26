//
//  BaseValueTransformer.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 26/02/2022.
//

import Foundation
import CoreData

class BaseValueTransformer: ValueTransformer {
    
    override class func allowsReverseTransformation() -> Bool{
        return true
    }
    override func transformedValue(_ value: Any?) -> Any?{
        guard let stringValue = value as? String else {return nil}
        
        return stringValue.data(using: .utf8)?.base64EncodedData()
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any?{
        guard let data = value as? Data, let decoded = Data(base64Encoded: data) else {return nil}
        
        return String(data: decoded, encoding: .utf8)
    }
}
