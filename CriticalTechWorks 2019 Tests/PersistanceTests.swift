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
    
    override func setUp() {
        super.setUp()
        
        sut1 = Article(title: "title 1",
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
        sut1 = nil
        super.tearDown()
    }

    func testSaveArticle_Success() {
        // when
        sut1.save { [weak self] in

            let container = try! Container()
            guard let url = self?.sut1.url else { return }
            let object = container.values(
                Article.self,
                matching: .url(url)
            )

            // then
            XCTAssertEqual(object.results.count, 1, "Object was saved")
            XCTAssertEqual(object.results.first?.url, self?.sut1.url, "Object url is not the same")
        }
    }
    
    func testDeleteArticle_Success() {
        // given
        sut1.save { [weak self] in
            
            let container = try! Container()
            guard let url = self?.sut1.url else { return }
            let object = container.values(
                Article.self,
                matching: .url(url)
            )
            
            XCTAssertEqual(object.results.first?.url, self?.sut1.url, "Objects was not saved")
        }

        let container = try! Container()
        let objects = container.values(
            Article.self,
            matching: .url("\(sut1.url)")
        )
        XCTAssertEqual(objects.results.count, 1, "Objects saved should be 1")

        // when
        sut1.delete {
            let container = try! Container()
            let objects = container.values(
                Article.self,
                matching: .url("\(self.sut1.url)")
            )
            
            // then
            XCTAssertEqual(objects.results.count, 0, "Objects saved should be 0")
        }
    }
    
    func testArticleisSaved_Success() {
        //given
        sut1.save { [weak self] in
            // then
            XCTAssertTrue(self?.sut1.isSaved ?? false, "Object was not saved")
        }
    }

    func testArticleisNotSaved_Success() {
        //given
        sut1.save { [weak self] in
            
            let container = try! Container()
            guard let url = self?.sut1.url else { return }
            let object = container.values(
                Article.self,
                matching: .url(url)
            )
            
            XCTAssertEqual(object.results.first?.url, self?.sut1.url, "Object was not saved")
        }
        
        XCTAssertTrue(sut1.isSaved, "Object was not saved")
        
        // when
        sut1.delete {
            let container = try! Container()
            let objects = container.values(
                Article.self,
                matching: .url("\(self.sut1.url)")
            )
            
            XCTAssertEqual(objects.results.count, 0, "Objects saved should be 0")
        }
        
        // then
        XCTAssertFalse(sut1.isSaved, "Object should have been deleted saved")
    }
    
    func testArticleConversionToManagedObject_Success() {
        // given
        let managedObject = sut1.managedObject()
        
        // when
        let articleManagedObject = Article(managedObject: managedObject)
        
        // then
        XCTAssertEqual(sut1!.url, articleManagedObject.url)
    }
    
    func testArticleValue_Success() {
        //given
        sut1.save { [weak self] in
            
            let container = try! Container()
            guard let url = self?.sut1.url else { return }
            let object = container.values(
                Article.self,
                matching: .url(url)
            )
            
            XCTAssertEqual(object.value(at: 0).url, self?.sut1.url, "Object was not saved")
        }
        
        XCTAssertTrue(sut1.isSaved, "Object was not saved")
    }
    
}
