//
//  HeadlineTableViewCellTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 23/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class HeadlineTableViewCellTests: XCTestCase {

    var sut: HeadlineTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = HeadlineTableViewCell(style: .default, reuseIdentifier: "cellId")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testHeadlineTableViewCell_Not_Nil() {
        // then
        XCTAssertNotNil(sut, "HeadlineTableViewCell is nil")
    }

}
