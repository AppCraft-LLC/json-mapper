//
//  PropertyTypes.swift
//  json example
//
//  Created by User on 13/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation

/// Types of class properties
enum PropertyType: String {
    case
    AnyObject = "ClassName",
    String = "String",
    Bool = "Bool",
    Int = "Int",
    Float = "Float",
    Double = "Double",
    Array = "Array",
    Null = "AnyObject"

    static let allValues = [AnyObject, String, Bool, Int, Float, Double, Array, Null]
}
