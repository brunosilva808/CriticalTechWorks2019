//
//  QueryType.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 19/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import RealmSwift

public protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}
