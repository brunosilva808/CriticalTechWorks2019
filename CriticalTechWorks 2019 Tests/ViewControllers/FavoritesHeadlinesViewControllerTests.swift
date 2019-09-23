//
//  FavoritesHeadlinesViewControllerTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 23/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class FavoritesHeadlinesViewControllerTests: XCTestCase {

    var sut: FavoritesHeadlinesViewController!
    var articles = [Article(title: "title 1",
                            articleDescription: "description 1",
                            url: "url 1",
                            urlToImage: "urlToImage1",
                            publishedAt: "published 1",
                            content: "content 1"),
                    Article(title: "title 2",
                            articleDescription: "description 2",
                            url: "url 2",
                            urlToImage: "urlToImage2",
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
        sut = FavoritesHeadlinesViewController()
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFavoritesHeadlinesViewController_NotNil() {
        XCTAssertNotNil(self.sut, "FavoritesHeadlinesViewController is nil")
    }
    
    func testViewWillAppear_Number_Of_Articles_Saved_isCorrect() {
        // given
        let numberOfResults = 0
        sut.articles = articles
        
        // when
        sut.viewWillAppear(true)
        
        // then
        XCTAssertEqual(sut.articles?.count, numberOfResults, "Number of saved articles in viewWillAppear is incorrect")
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
    
//    func testTableView_NumberOfRows_Correct() {
//        // given
//        var tableView: UITableView!
//        tableView = sut.tableView
//        
//        // when
//        sut.articles = articles
//        
//        // then
//        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0), articles.count, "Number of articles in TopHeadlinesViewController is incorrect")
//    }

}
