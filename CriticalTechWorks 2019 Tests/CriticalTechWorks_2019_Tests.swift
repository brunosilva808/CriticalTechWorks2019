//
//  CriticalTechWorks_2019_Tests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class CriticalTechWorks_2019_Tests: XCTestCase {

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
        let service = NewsService.headlines(countryCode: Environment.sources.value)
        let type = News.self
        var responseNews: News?
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        sessionProvider.request(type: type, service: service, completion: { (response) in
            switch response {
            case let .success(news):
                responseNews = news
            case let .failure(_):
                break
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
        let service = NewsService.headlines(countryCode: Environment.sources.value)
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
