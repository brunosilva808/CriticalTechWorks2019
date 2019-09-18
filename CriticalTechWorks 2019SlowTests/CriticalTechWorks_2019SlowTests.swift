//
//  CriticalTechWorks_2019SlowTests.swift
//  CriticalTechWorks 2019SlowTests
//
//  Created by Bruno on 18/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019

class CriticalTechWorks_2019SlowTests: XCTestCase {
    
    private var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
        
    func testCallToTopHeadlinesCompletes() {
        // given
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=58145f63433647a4884438f7fec6e6f5")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

}
