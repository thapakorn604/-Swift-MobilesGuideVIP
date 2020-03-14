//
//  AllPresenterTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 5/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

class AllPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: AllPresenter!
  var viewController : AllViewControllerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupAllPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupAllPresenter() {
    sut = AllPresenter()
    viewController = AllViewControllerSpy()
    sut.viewController = viewController
  }
  
  final class AllViewControllerSpy : AllViewControllerInterface {
    var isDisplayMobilesCalled = false
    var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []
    var errorMsg : String = ""
    
    func displayMobiles(viewModel: All.FetchMobiles.ViewModel) {
      
      isDisplayMobilesCalled = true
      switch viewModel.displayedMobiles {
      case .success(let mobiles):
        self.displayedMobiles = mobiles
      case .error(let error):
        self.errorMsg = error
      }
    }
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testDisplayMobilesWithSuccessCase() {
    // Given
    let content : Content<[Mobile]> = .success(data: getMobileList())
    // When
    let response = All.FetchMobiles.Response(content: content)
    sut.presentMobiles(response: response)

    // Then
    XCTAssertTrue(viewController.isDisplayMobilesCalled)
    
    XCTAssertEqual(viewController.displayedMobiles[0].price, "Price: $1.0")
    XCTAssertEqual(viewController.displayedMobiles[1].price, "Price: $2.0")
    XCTAssertEqual(viewController.displayedMobiles[2].price, "Price: $3.0")

    XCTAssertEqual(viewController.displayedMobiles[0].rating, "Rating: 1.0")
    XCTAssertEqual(viewController.displayedMobiles[1].rating, "Rating: 2.0")
    XCTAssertEqual(viewController.displayedMobiles[2].rating, "Rating: 3.0")
  }
  
  func testPresentMobilesWithFailCase() {
    // Given
    let errorMsg = "error message"
    let content : Content<[Mobile]> = .error(errorMsg)
    // When
    let response = All.FetchMobiles.Response(content: content)
    sut.presentMobiles(response: response)
    
    // Then
    XCTAssertTrue(viewController.isDisplayMobilesCalled)
    XCTAssertEqual(viewController.errorMsg, errorMsg)
  }
  
  func testPresentMobilesWithEmptyContent() {
    // Given
    let empty : [Mobile]  = []
    let content : Content<[Mobile]> = .success(data: empty)
    // When
    let response = All.FetchMobiles.Response(content: content)
    sut.presentMobiles(response: response)
    
    // Then
    XCTAssertTrue(viewController.isDisplayMobilesCalled)
    XCTAssert(viewController.displayedMobiles.count == 0)
  }
}

fileprivate func getMobileList() -> [Mobile] {
  return [
    Mobile(mobile: MobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: false),
    Mobile(mobile: MobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
    Mobile(mobile: MobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
  ]
}
