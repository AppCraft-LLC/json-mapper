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
    @IBOutlet weak var generateButton: NSButton!

    @IBAction func generateButtonPressed(_ sender: NSButton) {
        guard let mainWindow = self.view.window?.windowController as? MainWindowController else { return }
        guard let templatePopUp = mainWindow.templatePopUp else { return }
        guard let selectedItem = templatePopUp.selectedItem?.title else { return }

        let options: [String: Any] = [
            "rawJSON": editor.string,
            "className": classNameTextField.stringValue,
            "template": TemplateType(rawValue: selectedItem) ?? .OMStructTemplateSwift3
        ]

        let result = presenter.convertJSONToClassDefinitions(options: options)

        editor.string = result as NSString
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupEditor()
        self.setupGenerateButton()
    }

    // MARK: Help functions

    func clearEditor() {
        editor.string = ""
        classNameTextField.stringValue = "Base"
    }

    private func setupEditor() {
        editor.string = "{ \"status\" : 0 }"
        editor.becomeFirstResponder()
        editor.isSyntaxColoured = true
        editor.syntaxDefinitionName = "Javascript"
        editor.highlightsCurrentLine = true
        editor.tabWidth = 4
        editor.indentWithSpaces = true
    }

    private func setupGenerateButton() {
        generateButton.keyEquivalent = 	"\r"
    }
}
