//
//  CustomImageViewTests.swift
//  CriticalTechWorks 2019 Tests
//
//  Created by Bruno on 22/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
import Mockingjay
@testable import CriticalTechWorks_2019_BBC_News

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

    func testImageDownload_Success() {
        // given
        let urlString = "https://image.shutterstock.com/image-vector/photograph-black-vector-icons-600w-251281057.jpg"
        let promise = expectation(description: "Completion handler called")
        // Mockingjay
        let path = Bundle(for: type(of: self)).path(forResource: "image", ofType: "jpg")!
        let data = NSData(contentsOfFile: path)!
        self.stub(uri(urlString), jsonData(data as Data))
        
        // when
        sut.downloadImage(from: urlString) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(sut.image, "Image download failed")
    }
    
    func testImageFromCache_Success() {
        // given
        let urlString = "https://image.shutterstock.com/image-vector/photograph-black-vector-icons-600w-251281057.jpg"
        let promise1 = expectation(description: "Completion handler called")
        let promise2 = expectation(description: "Completion handler called")
        var imageFromCache: UIImage!
        // Mockingjay
        let path = Bundle(for: type(of: self)).path(forResource: "image", ofType: "jpg")!
        let data = NSData(contentsOfFile: path)!
        self.stub(uri(urlString), jsonData(data as Data))
        
        // when
        sut.downloadImage(from: urlString) {
            promise1.fulfill()
        }
        wait(for: [promise1], timeout: 5)
        
        sut.downloadImage(from: urlString) { [weak self] in
            imageFromCache = self?.sut.imageCache.object(forKey: urlString as NSString)
            promise2.fulfill()
        }
        wait(for: [promise2], timeout: 5)
        
        // then
        XCTAssertEqual(sut.image, imageFromCache, "Images should be equal")
    }
    
    func testDownloadImage_UrlIncorrect() {
        // given
        let urlString = "https://www.error.com/image-vector/photograph-black-vector-icons-600w-251281057.jpg"
        let promise = expectation(description: "Completion handler called")

        // Mockingjay
        let error = NSError(domain: "domain", code: 401, userInfo: nil)
        self.stub(uri(urlString), failure(error))
        
        // when
        sut.downloadImage(from: urlString) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(sut.image, "Image should be nil")
    }
    
    func testDownloadImage_Data_Nil() {
        // given
        let urlString = "https://www.error.com/image-vector/photograph-black-vector-icons-600w-251281057.jpg"
        let promise = expectation(description: "Completion handler called")
        
        // Mockingjay
        let data = NSData()
        self.stub(uri(urlString), jsonData(data as Data))
        
        // when
        sut.downloadImage(from: urlString) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(sut.image, "Image should be nil")
    }
    
    func testDownloadImage_UrlImage_Nil() {
        // given
        let urlString = ""
        let promise = expectation(description: "Completion handler called")
        
        // Mockingjay
        let data = NSData()
        self.stub(uri(urlString), jsonData(data as Data))
        
        // when
        sut.downloadImage(from: urlString) {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(sut.image, "Image should be nil")
    }

}
