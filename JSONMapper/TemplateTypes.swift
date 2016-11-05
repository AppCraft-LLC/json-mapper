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
    OMClassTemplateSwift3 = "OMClassSwift3.stencil",
    OMStructTemplateSwift3 = "OMStructSwift3.stencil",
    OMClassTemplateSwift2 = "OMClassSwift2.stencil",
    OMStructTemplateSwift2 = "OMStructSwift2.stencil"
    
    static let allValues = [OMClassTemplateSwift3, OMStructTemplateSwift3, OMClassTemplateSwift2, OMStructTemplateSwift2]
}
