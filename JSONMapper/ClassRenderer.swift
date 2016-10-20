//
//  ClassRenderer.swift
//  json example
//
//  Created by User on 13/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation
import Stencil

///Class, that render class body
class ClassRenderer{

    ///Render class body in string
    func render(_ classInfo: [String: Any], template: TemplateTypes) -> String?{
        var result: String?
        do {
            let context = Context(dictionary: classInfo)
            let template = try Template(named: template.rawValue)
            result = try template.render(context)
        }
        catch {
            print("Failed to render template \(template.rawValue): \(error)")
        }
        return result
    }

}
