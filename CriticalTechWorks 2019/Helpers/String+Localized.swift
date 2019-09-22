//
//  String.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 20/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

extension String {
    
    /// localize string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
