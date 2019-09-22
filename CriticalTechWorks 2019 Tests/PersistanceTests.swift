//
//  PersistanceTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
import RealmSwift
@testable import CriticalTechWorks_2019_PT

class PersistanceTests: XCTestCase {

    var sut1: Article!
    var sut2: Article!
    
    override func setUp() {
        super.setUp()
        
        sut1 = Article(title: "title 1", articleDescription: "description 1", url: "url 1", urlToImage: "urlToImage1", publishedAt: "published 1", content: "content 1")
        sut2 = Article(title: "title 2", articleDescription: "description 2", url: "url 2", urlToImage: "urlToImage2", publishedAt: "published 2", content: "content 2")
        
//        let container = try! Container()
//        try! container.write { transaction in
//            transaction.deleteAll()
//        }
    }

    override func tearDown() {
        sut1 = nil
        sut2 = nil
        super.tearDown()
    }

    func testSaveArticle() {
        // given
        let container = try! Container()
        let object = container.values(
            Article.self,
            matching: .url("\(sut1.url)")
        )
        
        print(object)
        print(object.results)

//        // when
//        sut1.save { [weak self] in
//
//            let container = try! Container()
//            let object = container.values(
//                Article.self,
//                matching: .url("\(self?.sut1.url)")
//            )
//
//            // then
//            XCTAssertNotEqual(object.results.first, self?.sut1.managedObject())
//        }
    }

}
