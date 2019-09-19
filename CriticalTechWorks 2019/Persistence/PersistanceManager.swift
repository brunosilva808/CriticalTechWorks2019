//
//  RealmManager.swift
//  iBanwallet
//
//  Created by Bruno Silva on 22/11/2018.
//

import Foundation
import RealmSwift

public final class WriteTransaction {
    private let realm: Realm
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Persistable>(_ value: T, update: Bool = false) {
        realm.add(value.managedObject(), update: update)
    }
}

public final class Container {
    private let realm: Realm
    
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func write(_ block: (WriteTransaction) throws -> Void)
        throws {
            let transaction = WriteTransaction(realm: realm)
            try realm.write {
                try block(transaction)
            }
    }
    
//    func getObjects<T: Object>(type: T.Type, _ block: (WriteTransaction) throws -> Void) {
//        print(realm.objects(type))
//
//        var array:[T] = []
//
//        let arrayRealm = realm.objects(type)
//        for object in arrayRealm {
//            array.append(object)
//        }
//
//        print(realm.objects(type).filter("title == Hawaii police training sparks false emergency sirens - Fox News"))
//    }

    public func values<T: Persistable> (_ type: T.Type, matching query: T.Query) -> FetchedResults<T> {
        var results = realm.objects(T.ManagedObject.self)
        
        if let predicate = query.predicate {
            results = results.filter(predicate)
        }
        
        results = results.sorted(by: query.sortDescriptors)
        
        return FetchedResults(results: results)
    }
    
}

public final class FetchedResults<T: Persistable> {
    internal let results: Results<T.ManagedObject>
    
    public var count: Int {
        return results.count
    }
    
    internal init(results: Results<T.ManagedObject>) {
        self.results = results
    }
    
    public func value(at index: Int) -> T {
        return T(managedObject: results[index])
    }
}
