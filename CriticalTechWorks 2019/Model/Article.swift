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
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
//        case source
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

final class ArticleObject: Object {
//    @objc dynamic var source: Source?
    @objc dynamic var author: String? = ""
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
        author = managedObject.author
        title = managedObject.title
        articleDescription = managedObject.articleDescription
        url = managedObject.url
        urlToImage = managedObject.urlToImage
        publishedAt = managedObject.publishedAt
        content = managedObject.content
    }
    
    public func managedObject() -> ArticleObject {
        let article = ArticleObject()
        article.author = author ?? ""
        article.title = title
        article.articleDescription = articleDescription
        article.url = url
        article.urlToImage = urlToImage
        article.publishedAt = publishedAt
        article.content = content
        
        return article
    }
}
