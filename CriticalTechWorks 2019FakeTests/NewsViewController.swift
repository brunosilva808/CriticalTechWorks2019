//
//  TopHeadlinesViewController.swift
//  CriticalTechWorks 2019FakeTests
//
//  Created by Bruno on 18/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019

class TopHeadlinesViewControllerTests: XCTestCase {

    var sut: NewsViewController!
    var window: UIWindow!

//    override func setUp() {
//        super.setUp()
//        sut = TopHeadlinesViewController()
//
//        let testBundle = Bundle(for: type(of: self))
//        let path = testBundle.path(forResource: "top_headlines", ofType: "json")
//        let data = try? Data(contentsOf: URL(string: path!)!, options: .alwaysMapped)
//
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=58145f63433647a4884438f7fec6e6f5")
//        let urlResponse = HTTPURLResponse(url: url!,
//                                          statusCode: 200,
//                                          httpVersion: nil,
//                                          headerFields: nil)
//
//        let sessionProvider = URLSessionProvider()
//    }
//
//    override func tearDown() {
//        sut = nil
//        super.tearDown()
//    }
//
//    func testCallToTopHeadlinesCompletes() {
//        // given
//    }

    override func setUp() {
        super.setUp()
        sut = NewsViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTopHeadlinesAPIComplete() {
        // given
        
        // when
        sut.getTopHeadlines()
        
        // then
    }
    
}
