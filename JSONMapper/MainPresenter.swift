//
//  MainPresenter.swift
//  JSONMapper
//
//  Created by Michael Ovchinnikov on 23/10/2016.
//  Copyright © 2016 Michael Ovchinnikov. All rights reserved.
//

import Cocoa
import SwiftyJSON

class MainPresenter: NSObject {
    func convertJSONToClassDefinitions(options: [String: Any]) -> String {
        guard let text = options["rawJSON"] as? String else { return "Invalid input JSON" }
        guard let dataFromString = text.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return "Error when converting string to UTF8" }
        let json = JSON(data: dataFromString)
        let classNameText = options["className"] as? String ?? "Base"
        
        var classModel: [String: String] = [:]
        _ = ObjectGenerator().generateClassForObject(json,
                                                    className: classNameText,
                                                    options: options,
                                                    classModel: &classModel)
        
        var resultString = ""
        for (_, classBody) in classModel {
            resultString = resultString + classBody + "\n\n"
        }
        
        return resultString.chomp()
    }
}
