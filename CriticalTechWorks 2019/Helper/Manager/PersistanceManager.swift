//
//  RealmManager.swift
//  iBanwallet
//
//  Created by Bruno Silva on 22/11/2018.
//

import Foundation
import RealmSwift

struct PersistanceManager {
    
    let realm = try! Realm()
    
    func get<T: Object>(object: T.Type) -> [T] {
        var array:[T] = []
        
        let realmCompanies = realm.objects(object.self)
        for abc in realmCompanies {
            array.append(abc)
        }
        
        return array
    }
    
    func save<T: Object>(array: [T]) {
        try! realm.write {
            realm.add(array, update: true)
        }
    }
    
}
