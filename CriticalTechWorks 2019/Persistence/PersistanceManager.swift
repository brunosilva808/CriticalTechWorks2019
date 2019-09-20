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
        print("Realm save")
    }
    
    func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managedObject())
    }
    
    func delete(_ value: RealmSwift.Object) {
        realm.delete(value)
        print("Realm delete")
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
