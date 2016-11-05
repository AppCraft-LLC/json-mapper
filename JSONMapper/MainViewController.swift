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

class MainViewController: NSViewController {
    private let presenter = MainPresenter()
    
    // MARK: Interface buider bindings
    
    @IBOutlet weak var editor: MGSFragariaView!
    @IBOutlet weak var classNameTextField: NSTextField!
    @IBOutlet weak var templateDropDown: NSPopUpButton!
    @IBOutlet weak var generateButton: NSButton!
    
    @IBAction func generateButtonPressed(_ sender: NSButton) {
        let options: [String: Any] = [
            "rawJSON": editor.string,
            "className": classNameTextField.stringValue,
            "template": TemplateTypes(rawValue: templateDropDown.selectedItem!.title) ?? .OMStructTemplateSwift3
        ]
        
        let result = presenter.convertJSONToClassDefinitions(options: options)
        
        editor.string = result as NSString
    }
    
    @IBAction func clearButtonPressed(_ sender: NSButton) {
        editor.string = ""
        classNameTextField.stringValue = "Base"
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupEditor()
        self.setupTemplateDropDown()
        self.setupGenerateButton()
    }
    
    // MARK: Help functions
    
    private func setupEditor() {
        editor.string = "{ \"status\" : 0 }"
        editor.becomeFirstResponder()
        editor.isSyntaxColoured = true
        editor.syntaxDefinitionName = "Javascript"
        editor.highlightsCurrentLine = true
        editor.tabWidth = 4
        editor.indentWithSpaces = true
    }
    
    private func setupTemplateDropDown() {
        templateDropDown.addItems(withTitles: TemplateTypes.allValues.map({ $0.rawValue }))
        templateDropDown.selectItem(at: 0)
    }
    
    private func setupGenerateButton() {
        generateButton.keyEquivalent = 	"\r"
    }
}

