//
//  ViewController.swift
//  JSONMapper
//
//  Created by Michael Ovchinnikov on 15/10/2016.
//  Copyright © 2016 Michael Ovchinnikov. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ViewController: NSViewController {
    @IBOutlet var inputJSONTextView: NSTextView!
    
    @IBAction func generateButtonPressed(_ sender: NSButton) {
        guard let text = inputJSONTextView.textStorage?.string else { return }
        guard let dataFromString = text.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
        let json = JSON(data: dataFromString)
        
        let options: [String: Any] = [
            "author": "Mike",
            "company": "AppCraft",
            "showInfoHeader": false
        ]
        
        var classModel: [String: String] = [:]
        
        ClassGenerator().generateClassForObject(json, className: "testClass", options: options, classModel: &classModel)
        
        var resultString = ""
        for (_, classBody) in classModel {
            resultString = resultString + classBody + "\n\n"
        }
        
        inputJSONTextView.textStorage?.mutableString.setString(resultString)
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInputTextView()
    }
    
    // MARK: Helper methods
    
    func setupInputTextView() {
        self.inputJSONTextView.isAutomaticQuoteSubstitutionEnabled = false;
        self.inputJSONTextView.isAutomaticDashSubstitutionEnabled = false;
        self.inputJSONTextView.isAutomaticTextReplacementEnabled = false;
    }
}

