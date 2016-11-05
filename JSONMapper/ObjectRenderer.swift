//
//  ClassRenderer.swift
//  json example
//
//  Created by User on 13/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation
import Stencil

class ObjectRenderer {

    /// Render class body in string
    func render(_ classInfo: [String: Any], template: TemplateType) -> String? {
        var result: String?
        do {
            let context = Context(dictionary: classInfo)
            let stencilTemplate = try Template(named: template.rawValue)
            result = try stencilTemplate.render(context)
        } catch {
            print("Failed to render template \(template.rawValue): \(error)")
        }
        return result
    }

}
