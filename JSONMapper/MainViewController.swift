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
    fileprivate let presenter = MainPresenter()

    // MARK: Interface buider bindings

    @IBOutlet weak var editor: MGSFragariaView!
    @IBOutlet weak var classNameTextField: NSTextField!
    @IBOutlet weak var resultView: MGSFragariaView!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        classNameTextField.delegate = self

        self.setupEditor()
        self.setupResultView()
    }

    // MARK: Help functions

    func clearEditor() {
        editor.string = ""
        classNameTextField.stringValue = "Base"
    }

    func performJSONToObjectConversion() {
        guard let mainWindow = self.view.window?.windowController as? MainWindowController else { return }
        guard let templatePopUp = mainWindow.templatePopUp else { return }
        guard let selectedItem = templatePopUp.selectedItem?.title else { return }

        let options: [String: Any] = [
            "rawJSON": editor.string,
            "className": classNameTextField.stringValue,
            "template": TemplateType(rawValue: selectedItem) ?? .OMStructTemplateSwift3
        ]

        let result = presenter.convertJSONToClassDefinitions(options: options)

        resultView.string = result as NSString
    }

    private func setupEditor() {
        editor.string = "{ \"status\" : 0 }"
        editor.becomeFirstResponder()
        editor.isSyntaxColoured = true
        editor.syntaxDefinitionName = "Javascript"
        editor.highlightsCurrentLine = true
        editor.tabWidth = 4
        editor.indentWithSpaces = true
        editor.textViewDelegate = self
    }

    private func setupResultView() {
        resultView.isSyntaxColoured = editor.isSyntaxColoured
        resultView.tabWidth = editor.tabWidth
        resultView.indentWithSpaces = editor.indentWithSpaces
        resultView.syntaxDefinitionName = editor.syntaxDefinitionName
    }
}

// MARK: - MGSFragariaTextViewDelegate

extension MainViewController: MGSFragariaTextViewDelegate, MGSDragOperationDelegate {
    func textDidChange(_ notification: Notification) {
        self.performJSONToObjectConversion()
    }
}

// MARK: - NSTextFieldDelegate

extension MainViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        self.performJSONToObjectConversion()
    }
}
