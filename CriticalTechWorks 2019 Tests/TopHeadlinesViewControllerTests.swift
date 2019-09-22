//
//  TopHeadlinesViewControllerTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
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

    func testTopHeadlinesViewControllerNotNil() {
        XCTAssertNotNil(self.sut, "TopHeadlinesViewController is nil")
    }

}
