//
//  MainWindowController.swift
//  JSONMapper
//
//  Created by Michael Ovchinnikov on 12/11/2016.
//  Copyright © 2016 Michael Ovchinnikov. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    var viewController: MainViewController? {
        get {
            return 	self.window?.contentViewController as? MainViewController
        }
    }

    // MARK: Interface builder bindings

    @IBOutlet weak var templatePopUp: NSPopUpButton!

    @IBAction func eraseButtonPressed(_ sender: NSButton) {
        guard let mainViewController = self.viewController else { return }
        mainViewController.clearEditor()
    }

    // MARK: View lifecycle

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.titleVisibility = .hidden
        templatePopUp.menu?.delegate = self
        self.setupTemplatePopUp()
    }

    // MARK: Help functions

    private func setupTemplatePopUp() {
        templatePopUp.addItems(withTitles: TemplateType.allValues.map({ $0.rawValue }))
        templatePopUp.selectItem(at: 0)
    }
}

// MARK: - NSMenuDelegate

extension MainWindowController: NSMenuDelegate {
    func menuDidClose(_ menu: NSMenu) {
        if menu == self.templatePopUp.menu {
            guard let mainViewController = self.viewController else { return }
            mainViewController.performJSONToObjectConversion()
        }
    }
}
