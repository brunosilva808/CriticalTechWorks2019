//
//  CriticalTechWorks_2019FakeTests.swift
//  CriticalTechWorks 2019FakeTests
//
//  Created by Bruno on 18/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019

class CriticalTechWorks_2019FakeTests: XCTestCase {

//    var sut: TopHeadlinesViewController!
//
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

    var sessionProvider: URLSessionProvider!
    
    override func setUp() {
        super.setUp()
        sessionProvider = URLSessionProvider()
    }
    override func tearDown() {
        sessionProvider = nil
        super.tearDown()
    }
    
    func testRequest() {
        // given
        let service = NewsService.headlines(country: "US")
        let type = News.self
        var responseNews: News?
        var responseError: NetworkError?
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        sessionProvider.request(type: type, service: service, completion: { (response) in
            switch response {
            case let .success(news):
                responseNews = news
            case let .failure(error):
                responseError = error
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseNews)
    }
}
