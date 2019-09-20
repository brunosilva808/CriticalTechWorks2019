//
//  Environment.swift
//  Move Me
//
//  Created by Bruno Silva on 10/04/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import Foundation

enum Environment: String {
    case sources = "SOURCES"
}

extension Environment {
    
    var value: String {
        guard let plist = Bundle.main.infoDictionary else{
            fatalError("Couldn't find plist file")
        }
        
        guard let result = plist[rawValue] else {
            fatalError("Can't find value for key \(rawValue)")
        }
        
        guard let rslt = result as? String else {
            fatalError("Value for key \(rawValue) is not a String")
        }
        
        return rslt
    }
}
