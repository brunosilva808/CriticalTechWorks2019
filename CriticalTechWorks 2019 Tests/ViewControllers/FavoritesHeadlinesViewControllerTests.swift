//
//  FavoritesHeadlinesViewControllerTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 23/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class FavoritesHeadlinesViewControllerTests: XCTestCase {

    var sut: FavoritesHeadlinesViewController!
    
    override func setUp() {
        super.setUp()
        sut = FavoritesHeadlinesViewController()
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFavoritesHeadlinesViewController_NotNil() {
        XCTAssertNotNil(self.sut, "FavoritesHeadlinesViewController is nil")
    }

}
