//
//  HeadlinesViewControllerTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 23/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class HeadlineViewControllerTests: XCTestCase {

    var sut: HeadlineViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = HeadlineViewController()
        sut.article = Article(title: "title 1",
                      articleDescription: "description 1",
                      url: "url 1",
                      urlToImage: "urlToImage1",
                      publishedAt: "published 1",
                      content: "content 1")
        sut.loadView()
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHeadlinesViewController_NotNil() {
        XCTAssertNotNil(sut, "HeadlineViewController is nil")
    }
    
    func testArticle_isSaved() {
        // given
        let promise = expectation(description: "Article saved")
        
        // when
        sut.article.save {
            promise.fulfill()
        }
        sut.viewDidLoad()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertTrue(sut.article.isSaved, "Article not saved")
    }
    
    func testArticle_With_Empty_URLImage() {
        // given
        let article = Article(title: "title 1",
                              articleDescription: "description 1",
                              url: "url 1",
                              urlToImage: "",
                              publishedAt: "published 1",
                              content: "content 1")
        sut.article = article
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertEqual(sut.article.urlToImage, article.urlToImage, "Image urls are different")
    }
    
}
