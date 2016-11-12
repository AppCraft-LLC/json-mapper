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

    @IBAction func eraseButtonPressed(_ sender: NSButton) {
        guard let mainViewController = self.viewController else { return }
        mainViewController.clearEditor()
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.titleVisibility = .hidden
    }

}
