//
//  FavouritePresenterTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

class FavouritePresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: FavouritePresenter!
  var viewController : FavouriteViewControllerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFavouritePresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupFavouritePresenter() {
    sut = FavouritePresenter()
    viewController = FavouriteViewControllerSpy()
    sut.viewController = viewController
  }
  
  final class FavouriteViewControllerSpy : FavouriteViewControllerInterface {
    var isDisplayFavouritesCalled = false
    var isDisplayDeletedFavouriteCalled = false
    var displayedFavourites: [Favourite.FavMobiles.ViewModel.DisplayedFavourite] = []
    
    func displayFavourites(viewModel: Favourite.FavMobiles.ViewModel) {
      isDisplayFavouritesCalled = true
      self.displayedFavourites = viewModel.displayedFavourites
    }
    
    func displayDeletedFavourite(viewModel: Favourite.FavMobiles.ViewModel) {
      isDisplayDeletedFavouriteCalled = true
      self.displayedFavourites = viewModel.displayedFavourites
    }
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testPresentFavouritesWithCorrectFormat() {
    // Given
    let mockFavouriteList = getFavouriteList()
    // When
    let response = Favourite.FavMobiles.Response(favMobiles: mockFavouriteList)
    sut.presentFavourites(response: response)
    // Then
    XCTAssertTrue(viewController.isDisplayFavouritesCalled)
    XCTAssertEqual(viewController.displayedFavourites[0].price, "Price: $1.0")
    XCTAssertEqual(viewController.displayedFavourites[1].price, "Price: $2.0")
    XCTAssertEqual(viewController.displayedFavourites[2].price, "Price: $3.0")
    
    XCTAssertEqual(viewController.displayedFavourites[0].rating, "Rating: 1.0")
    XCTAssertEqual(viewController.displayedFavourites[1].rating, "Rating: 2.0")
    XCTAssertEqual(viewController.displayedFavourites[2].rating, "Rating: 3.0")
  }
  
  func testPresentFavouritesWithEmptyContent() {
    // Given
    let empty : [Mobile]  = []
    // When
    let response = Favourite.FavMobiles.Response(favMobiles: empty)
    sut.presentFavourites(response: response)
    // Then
    XCTAssertTrue(viewController.isDisplayFavouritesCalled)
    XCTAssert(viewController.displayedFavourites.count == 0)
  }
  
  func testPresentDeletedFavouriteWithCorrectFormat() {
    // Given
    let mockFavouriteList = getFavouriteList()
    // When
    let response = Favourite.FavMobiles.Response(favMobiles: mockFavouriteList)
    sut.presentDeletedFavourite(response: response)
    // Then
    XCTAssertTrue(viewController.isDisplayDeletedFavouriteCalled)
    XCTAssertEqual(viewController.displayedFavourites[0].price, "Price: $1.0")
    XCTAssertEqual(viewController.displayedFavourites[1].price, "Price: $2.0")
    XCTAssertEqual(viewController.displayedFavourites[2].price, "Price: $3.0")
    
    XCTAssertEqual(viewController.displayedFavourites[0].rating, "Rating: 1.0")
    XCTAssertEqual(viewController.displayedFavourites[1].rating, "Rating: 2.0")
    XCTAssertEqual(viewController.displayedFavourites[2].rating, "Rating: 3.0")
  }
  
  func testPresentDeletedFavouriteWithEmptyContent() {
    // Given
    let empty : [Mobile]  = []
    // When
    let response = Favourite.FavMobiles.Response(favMobiles: empty)
    sut.presentDeletedFavourite(response: response)
    // Then
    XCTAssertTrue(viewController.isDisplayDeletedFavouriteCalled)
    XCTAssert(viewController.displayedFavourites.count == 0)
  }
}

fileprivate func getFavouriteList() -> [Mobile] {
  return [
    Mobile(mobile: MobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: true),
    Mobile(mobile: MobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: true),
    Mobile(mobile: MobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: true)
  ]
}
