//
//  TemplateTypes.swift
//  json example
//
//  Created by User on 13/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation

///Types of available for rendering templates 
enum TemplateTypes: String{
    case
    ClassTemplate = "ClassTemplate.stencil",
    StructTemplate = "StructTemplate.stencil"
    
    static let allValues = [ClassTemplate, StructTemplate]
}