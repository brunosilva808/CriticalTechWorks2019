//
//  String+Locale.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 18/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

extension NSLocale {

    func getCountryCode() -> String {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            return countryCode
        }
        
        return ""
    }
}
