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

    var sut: TopHeadlinesViewController!
    
    override func setUp() {
        super.setUp()
        sut = TopHeadlinesViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCallToTopHeadlinesCompletes() {
    
    }

}
