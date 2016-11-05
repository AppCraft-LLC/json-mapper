//
//  NegasonicTeenageWarhead.swift
//  json example
//
//  Created by User on 12/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation
import Stencil
import SwiftyJSON

///Generator of classes, based on JSON-responses
class ObjectGenerator {

    /// Generate class with specified name and template, keeping all children classes in classModel
    func generateClassForObject(_ parsedJSONObject: JSON, className: String, options: [String: Any], classModel: inout [String: String]) -> String {
        let resultClassName = String().makeResponseClassName(className)
        var classInfo = self.prepareClassInfo(resultClassName, options: options)

        var propertiesFromJson: [String: JSON]?
        if let propertiesDictionary = parsedJSONObject.dictionary {
            propertiesFromJson = propertiesDictionary
        } else if let firstObjectPropertiesDictionary = parsedJSONObject[0].dictionary {
            propertiesFromJson = firstObjectPropertiesDictionary
        }

        if propertiesFromJson != nil {
            classInfo["properties"] = self.generateClassProperties(propertiesFromJson!, options: options, classModel: &classModel)
        }

        let template = options["template"] as? TemplateType
        if let classFile = ObjectRenderer().render(classInfo, template: (template ?? .OMClassTemplateSwift3)) {
            classModel[resultClassName] = classFile
        }

        return resultClassName
    }

    /// Generate class info based on selected options
    private func prepareClassInfo(_ className: String, options: [String: Any]) -> [String: Any] {
        var classInfo: [String: Any] = ["className": className]

        if let showInfoHeader = options["showInfoHeader"] as? Bool {
            classInfo["showInfoHeader"] = showInfoHeader
        }

        if let author = options["author"] as? String {
            classInfo["author"] = author
        }

        if let company = options["company"] as? String {
            classInfo["company"] = company
        }

        var date: Date
        if let dateFromOprions = options["date"] as? Date {
            date = dateFromOprions
        } else {
            date = Date()
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        classInfo["date"] = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        classInfo["year"] = dateFormatter.string(from: date)

        return classInfo
    }

    /// Generate properties for class
    private func generateClassProperties(_ propertiesFromJson: [String: JSON], options: [String: Any], classModel: inout [String: String]) -> Array<[String: String]> {
        var classProperties: Array<[String: String]> = []
        for (key, jsonValue) in propertiesFromJson {
            let name: String = key
            let type: PropertyType = checkType(jsonValue)
            var property: Dictionary<String, String> = [:]
            property["name"] = name
            if type == .AnyObject {
                let childClassName = self.generateClassForObject(jsonValue, className: name, options: options, classModel: &classModel)
                property["type"] = childClassName
            } else if type == .Array {
                let arrayType = self.getArrayType(jsonValue, forPropertyName: name, options: options, classModel: &classModel)
                property["type"] = arrayType
            } else {
                property["type"] = type.rawValue
            }

            classProperties.append(property)
        }
        return classProperties
    }

    /// Get type for array properties
    private func getArrayType(_ jsonValue: JSON, forPropertyName: String, options: [String: Any], classModel: inout [String: String]) -> String {
        var arrayTypeStr: String
        let first = jsonValue[0]
        let typeOfFirst = self.checkType(first)
        if typeOfFirst == .AnyObject {
            arrayTypeStr = self.generateClassForObject(first, className: forPropertyName, options: options, classModel: &classModel)
        } else if typeOfFirst == .Array {
            arrayTypeStr = self.getArrayType(first, forPropertyName: forPropertyName, options: options, classModel: &classModel)
        } else {
            arrayTypeStr = typeOfFirst.rawValue
        }
        return "[\(arrayTypeStr)]"
    }

    /// Get type of property
    private func checkType(_ value: JSON) -> PropertyType {
        if value.type == .null {
            return .Null
        }
        var js: JSON = value as JSON
        var type: PropertyType = .AnyObject

        if let _ = js.string {
            type = .String
        } else if let _ = js.bool {
            type = .Bool
        } else if let validNumber = js.number {

            //Smarter number type detection. Rather than use generic NSNumber, we can use a specific type. These are grouped into the common Swift number types.
            let numberRef = CFNumberGetType(validNumber as CFNumber)

            switch numberRef {

            case .sInt8Type:
                fallthrough
            case .sInt16Type:
                fallthrough
            case .sInt32Type:
                fallthrough
            case .sInt64Type:
                fallthrough
            case .charType:
                fallthrough
            case .shortType:
                fallthrough
            case .intType:
                fallthrough
            case .longType:
                fallthrough
            case .longLongType:
                fallthrough
            case .cfIndexType:
                fallthrough
            case .nsIntegerType:
                type = .Int

            case .float32Type:
                fallthrough
            case.float64Type:
                fallthrough
            case .cgFloatType:
                fallthrough
            case .floatType:
                type = .Float

            case .doubleType:
                type = .Double
            }

        } else if let _ = js.array {
            type = .Array
        }

        return type
    }
}
