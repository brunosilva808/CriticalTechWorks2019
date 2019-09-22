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
    
//    func testTopHeadlinesAPIRequestSuccess() {
//        // given
//        let service = NewsService.headlines(countryCode: Environment.sources.value)
//        let type = News.self
//        var responseNews: News?
//        let promise = expectation(description: "Completion handler invoked")
//        
//        // when
//        sessionProvider.request(type: type, service: service, completion: { (response) in
//            switch response {
//            case let .success(news):
//                responseNews = news
//            case .failure(_):
//                break
//            }
//            
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 5)
//        
//        // then
//        XCTAssertNotNil(responseNews)
//    }
//    
//    func testTopHeadlinesAPIRequestErrorUnknown() {
//        // given
//        let service = NewsService.headlines(countryCode: Environment.sources.value)
//        let type = News.self
//        var responseError: NetworkError?
//        let promise = expectation(description: "Completion handler invoked")
//        
//        // when
//        sessionProvider.request(type: type, service: service, completion: { (response) in
//            switch response {
//            case .success(_):
//                break
//            case let .failure(error):
//                responseError = error
//            }
//            
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 5)
//        
//        // then
//        XCTAssertNotNil(responseError)
//    }
    
    func testTopHeadlines_APIRequest_WithMockingjay_ErrorUknown() {
        // given
        let service = NewsService.headlines(countryCode: Environment.sources.value)
        let typeObject = Article.self
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
            case .success(_):
                break
            case let .failure(error):
                responseError = error
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseError, "Top Headlines APIRequestWithMockingjayErrorUknown failed")
    }
    
    func testTopHeadlines_APIRequest_WithMockingjay_Success() {
        // given
        let service = NewsService.headlines(countryCode: Environment.sources.value)
        let typeObject = News.self
        var responseNews: News?
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
            case .failure(_):
                break
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseNews, "Top Headlines APIRequestWithMockingjaySuccess failed")
    }

}
