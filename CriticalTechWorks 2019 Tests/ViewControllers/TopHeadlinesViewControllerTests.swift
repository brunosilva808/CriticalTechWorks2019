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
