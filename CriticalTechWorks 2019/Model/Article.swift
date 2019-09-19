//
//  Article.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 19/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import RealmSwift

struct Article: Codable {
//    let source: Source
//    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
//
    enum CodingKeys: String, CodingKey {
////        case source
//        case author
        case title
        case articleDescription = "description"
        case publishedAt
        case content
        case urlToImage
        case url
//        case content
    }
    
    func isSaved() -> Bool {
        let container = try! Container()
        let results = container.values(
            Article.self,
            matching: .url("\(self.url)")
        )

        return results.count == 0 ? false : true
    }
    
    func save(completed: @escaping (() -> Void) ) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let container = try! Container()
                try! container.write { transaction in
                    transaction.add(self)
                    
                    completed()
                }
            }
        }
    }
    
    func delete(completed: @escaping (() -> Void) ) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let container = try! Container()
                let object = container.values(
                    Article.self,
                    matching: .url("\(self.url)")
                )
                
                try! container.write { transaction in
                    if let article = object.results.first {
                        transaction.delete(article)
                    }
                        
                    completed()
                }
            }
        }
    }
}

final class ArticleObject: Object {
//    @objc dynamic var source: Source?
//    @objc dynamic var author: String? = ""
    @objc dynamic var title: String = ""
    @objc dynamic var articleDescription: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

extension Article: Persistable {
    public init(managedObject: ArticleObject) {
//        author = managedObject.author
        title = managedObject.title
        articleDescription = managedObject.articleDescription
        url = managedObject.url
        urlToImage = managedObject.urlToImage
        publishedAt = managedObject.publishedAt
        content = managedObject.content
    }
    
    public func managedObject() -> ArticleObject {
        let article = ArticleObject()
//        article.author = author ?? ""
        article.title = title
        article.articleDescription = articleDescription ?? ""
        article.url = url
        article.urlToImage = urlToImage ?? ""
        article.publishedAt = publishedAt
        article.content = content ?? ""
        
        return article
    }
}

extension Article {
    public enum Query: QueryType {
        case url(String)
        
        public var predicate: NSPredicate? {
            switch self {
            case .url(let value):
                return NSPredicate(format: "url == %@",
                                   value)
            }
        }
        
        public var sortDescriptors: [SortDescriptor] {
            return [SortDescriptor(keyPath: "url")]
        }
    }
}
