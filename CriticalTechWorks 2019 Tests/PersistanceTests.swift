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

    var sut: Article!
    
    override func setUp() {
        super.setUp()
        
        sut = Article(title: "title 1",
                       articleDescription: "description 1",
                       url: "url 1",
                       urlToImage: "urlToImage1",
                       publishedAt: "published 1",
                       content: "content 1")
        
        let container = try! Container()
        try! container.write { transaction in
            transaction.deleteAll()
        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSaveArticle_Success() {
        // given
        let promise = expectation(description: "Article saved")
        
        // when
        sut.save {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        let container = try! Container()
        let object = container.values(
            Article.self,
            matching: .url(sut.url)
        )
        
        XCTAssertEqual(object.results.count, 1, "Object was not saved")
        XCTAssertEqual(object.results.first?.url, self.sut.url, "Object url is not the same")
    }
    
    func testDeleteArticle_Success() {
        // given
        let promiseSave = expectation(description: "Article saved")
        let promiseDelete = expectation(description: "Article deleted")
        
        // given
        sut.save {
            promiseSave.fulfill()
        }
        wait(for: [promiseSave], timeout: 5)
        
        let container = try! Container()
        let object = container.values(
            Article.self,
            matching: .url(sut.url)
        )
        XCTAssertEqual(object.results.first?.url, sut.url, "Objects was not saved")

        // when
        sut.delete {
            promiseDelete.fulfill()
        }
        wait(for: [promiseDelete], timeout: 5)
        
        // then
        let objects = container.values(
            Article.self,
            matching: .url("\(sut.url)")
        )
        XCTAssertEqual(objects.results.count, 0, "Objects was not deleted")
    }
    
    func testArticleisSaved_Success() {
        // given
        let promiseSave = expectation(description: "Article saved")
        
        // when
        sut.save {
            promiseSave.fulfill()
        }
        wait(for: [promiseSave], timeout: 5)
        
        // then
        XCTAssertTrue(sut.isSaved, "Object was not saved")
    }
    
    func testArticleConversionToManagedObject_Success() {
        // given
        let managedObject = sut.managedObject()
        
        // when
        let articleManagedObject = Article(managedObject: managedObject)
        
        // then
        XCTAssertEqual(sut!.url, articleManagedObject.url)
    }
    
    func testArticleKey_isCorrect_Success() {
        // given
        let promiseSave = expectation(description: "Article saved")
        
        // when
        sut.save {
            promiseSave.fulfill()
        }
        wait(for: [promiseSave], timeout: 5)
        
        let container = try! Container()
        let object = container.values(
            Article.self,
            matching: .url(sut.url)
        )
        
        XCTAssertEqual(object.value(at: 0).url, sut.url, "Object was not saved")
    }
    
}
