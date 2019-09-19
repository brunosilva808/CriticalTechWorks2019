//
//  CriticalTechWorks_2019FakeTests.swift
//  CriticalTechWorks 2019FakeTests
//
//  Created by Bruno on 18/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019

class NewsServiceTests: XCTestCase {

    var sessionProvider: URLSessionProvider!
    
    override func setUp() {
        super.setUp()
        sessionProvider = URLSessionProvider()
    }
    override func tearDown() {
        sessionProvider = nil
        super.tearDown()
    }
    
    func testTopHeadlinesRequestSuccess() {
        // given
        let countryCode = NSLocale().getCountryCode()
        let service = NewsService.headlines(countryCode: countryCode)
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
    
    func testTopHeadlinesRequestErrorUnknown() {
        // given
        let countryCode = NSLocale().getCountryCode()
        let service = NewsService.headlines(countryCode: countryCode)
        let type = Article.self
        var responseError: NetworkError?
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        sessionProvider.request(type: type, service: service, completion: { (response) in
            switch response {
            case .success(_):
                break
            case let .failure(error):
                responseError = error
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseError)
    }
}
