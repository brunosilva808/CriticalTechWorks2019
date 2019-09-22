//
//  CustomImageViewTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import CriticalTechWorks_2019_PT

class CustomImageViewTests: XCTestCase {

    var sut: CustomImageView!
    
    override func setUp() {
        super.setUp()
        
        sut = CustomImageView(frame: .zero)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() {
        // given
        let urlString = "https://image.shutterstock.com/image-vector/photograph-black-vector-icons-600w-251281057.jpg"
        
        // when
        sut.downloadImage(from: urlString) { [weak self] in
            // then
            XCTAssertNotNil(self?.sut.image)
        }
    }

}
