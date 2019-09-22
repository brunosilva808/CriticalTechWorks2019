//
//  CriticalTechWorks_2019_Tests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT
import Mockingjay

class TopHeadlinesAPITests: XCTestCase {

    var sessionProvider: URLSessionProvider!
    
    override func setUp() {
        super.setUp()
        sessionProvider = URLSessionProvider()
    }
    override func tearDown() {
        sessionProvider = nil
        super.tearDown()
    }
    
    func testTopHeadlines_APIRequest_WithMockingjay_ErrorUknown() {
        // given
        let service = NewsService.headlines(countryCode: Environment.sources.value)
        let typeObject = Article.self
        var responseArticle: Article?
        var responseError: NetworkError?
        let promise = expectation(description: "Completion handler invoked")
        
        // Mockingjay
        let path = Bundle(for: type(of: self)).path(forResource: "top_headlines", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let stringUrl = service.baseURL.absoluteString + service.path + "?country=PT&apiKey=58145f63433647a4884438f7fec6e6f5"
        self.stub(uri(stringUrl), jsonData(data as Data))
        
        // when
        sessionProvider.request(type: typeObject, service: service, completion: { (response) in
            switch response {
            case let .success(news):
                responseArticle = news
            case let .failure(error):
                responseError = error
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseArticle, "Top Headlines APIRequestWithMockingjayErrorUknown news object should be nil")
        XCTAssertNotNil(responseError, "Top Headlines APIRequestWithMockingjayErrorUknown failed")
    }
    
    func testTopHeadlines_APIRequest_WithMockingjay_Success() {
        // given
        let service = NewsService.headlines(countryCode: Environment.sources.value)
        let typeObject = News.self
        var responseNews: News?
        var responseError: NetworkError?
        let promise = expectation(description: "Completion handler invoked")
        
        // Mockingjay
        let path = Bundle(for: type(of: self)).path(forResource: "top_headlines", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let stringUrl = service.baseURL.absoluteString + service.path + "?country=PT&apiKey=58145f63433647a4884438f7fec6e6f5"
        self.stub(uri(stringUrl), jsonData(data as Data))
        
        // when
        sessionProvider.request(type: typeObject, service: service, completion: { (response) in
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
        XCTAssertNil(responseError, "Top Headlines APIRequestWithMockingjaySuccess error should be nil")
        XCTAssertNotNil(responseNews, "Top Headlines APIRequestWithMockingjaySuccess news object should not be nil")
    }

}
