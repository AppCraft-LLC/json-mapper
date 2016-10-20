//
//  StringExtension.swift
//  json example
//
//  Created by User on 13/10/16.
//  Copyright © 2016 a. All rights reserved.
//

import Foundation

extension String {
    mutating func makeFirstCharUpperCase(){
        self.replaceSubrange(self.startIndex...self.startIndex, with: String(self[self.startIndex]).capitalized)
    }
    
    func makeResponseClassName(_ className: String) -> String{
        var result = className + "Response"
        result.makeFirstCharUpperCase()
        return result
    }
}
