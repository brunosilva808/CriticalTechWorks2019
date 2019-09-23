//
//  TopHeadlinesViewControllerTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
import Mockingjay
@testable import CriticalTechWorks_2019_PT

class TopHeadlinesViewControllerTests: XCTestCase {

    var sut: TopHeadlinesViewController!
    var articles = [Article(title: "title 1",
                            articleDescription: "description 1",
                            url: "url 1",
                            urlToImage: "urlToImage1",
                            publishedAt: "published 1",
                            content: "content 1"),
                    Article(title: "title 2",
                            articleDescription: "description 2",
                            url: "url 2",
                            urlToImage: "",
                            publishedAt: "published 2",
                            content: "content 2"),
                    Article(title: "title 3",
                            articleDescription: "description 3",
                            url: "url 3",
                            urlToImage: "urlToImage3",
                            publishedAt: "published 3",
                            content: "content 3")]
    
    override func setUp() {
        super.setUp()
        sut = TopHeadlinesViewController()
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTopHeadlinesViewController_NotNil() {
        XCTAssertNotNil(self.sut, "TopHeadlinesViewController is nil")
    }
    
    func testRightButton_Should_Not_Be_Nil() {
        let rightBarButton = sut.navigationItem.rightBarButtonItem
        XCTAssertNotNil(rightBarButton, "Should not be nil")
    }
    
    func testTableViewCell_ForRowAtIndexPath_isNotNill() {
        // given
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        sut.articles = articles
        let cell = sut.tableView.dataSource!.tableView(sut.tableView, cellForRowAt: indexPath)
        
        // then
        XCTAssertNotNil(cell, "Cell is nil")
    }
    
    func testTableViewCell_ForRowAtIndexPath_urlToImage_isEmpty() {
        // given
        let indexPath = IndexPath(row: 1, section: 0)
        
        // when
        sut.articles = articles
        let cell = sut.tableView.dataSource!.tableView(sut.tableView, cellForRowAt: indexPath)
        
        // then
        XCTAssertNotNil(cell, "Cell is nil")
    }
    
    func testTableView_NumberOfRows_Correct() {
        // given
        let numberOfArticles = articles.count
        var tableView: UITableView!
        tableView = sut.tableView
        
        // when
        sut.articles = articles
        
        // then
        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0), numberOfArticles, "Number of articles in TopHeadlinesViewController is incorrect")
    }
    
//    func testResults() {
//        // given
//        let service = NewsService.headlines(countryCode: Environment.sources.value)
//        let numberOfResults = 20
//
//        // Mockingjay
//        let path = Bundle(for: type(of: self)).path(forResource: "top_headlines", ofType: "json")!
//        let data = NSData(contentsOfFile: path)!
//        let stringUrl = service.baseURL.absoluteString + service.path + "?country=PT&apiKey=58145f63433647a4884438f7fec6e6f5"
//        self.stub(uri(stringUrl), jsonData(data as Data))
//        
//        // when
//        let promise = expectation(description: "")
//        self.sut.getTopHeadlines()
//        wait(for: [promise], timeout: 5)
//        
//        // then
//        print(sut.articles?.count ?? 0)
//        print(numberOfResults)
//        XCTAssertEqual(sut.articles?.count ?? 0, numberOfResults)
//    }

}
