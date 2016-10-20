//
//  ViewController.swift
//  JSONMapper
//
//  Created by Michael Ovchinnikov on 15/10/2016.
//  Copyright © 2016 Michael Ovchinnikov. All rights reserved.
//

import Cocoa
import SwiftyJSON
import Fragaria

class ViewController: NSViewController {
    @IBOutlet weak var editor: MGSFragariaView!
    @IBOutlet weak var classNameTextField: NSTextField!
    
    @IBAction func generateButtonPressed(_ sender: NSButton) {
        let text = editor.string as String
        guard let dataFromString = text.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
        let json = JSON(data: dataFromString)
        
        let options: [String: Any] = [
            "author": "Mike",
            "company": "AppCraft",
            "showInfoHeader": false
        ]
        
        var classModel: [String: String] = [:]
        
        ClassGenerator().generateClassForObject(json,
                                                className: classNameTextField.stringValue,
                                                options: options,
                                                classModel: &classModel)
        
        var resultString = ""
        for (_, classBody) in classModel {
            resultString = resultString + classBody + "\n\n"
        }
        
        editor.string = resultString as NSString
    }
    
    @IBAction func clearButtonPressed(_ sender: NSButton) {
        editor.string = ""
        classNameTextField.stringValue = "Base"
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editor.becomeFirstResponder()
        
        editor.isSyntaxColoured = true
        editor.syntaxDefinitionName = "Javascript"
        editor.string = "{ \"status\" : 0}"
        editor.highlightsCurrentLine = true
        
        editor.tabWidth = 4
        editor.indentWithSpaces = true
    }
}

