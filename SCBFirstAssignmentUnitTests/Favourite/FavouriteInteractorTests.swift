//
//  FavouriteInteractorTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

class FavouriteInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: FavouriteInteractor!
  var presenter : FavouritePresenterSpy!
  var worker : MobilesWorkerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFavouriteInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupFavouriteInteractor() {
    sut = FavouriteInteractor()
    presenter = FavouritePresenterSpy()
    worker = MobilesWorkerSpy(store: MobilesMockStore())
    sut.presenter = presenter
    sut.worker = worker
  }

  // MARK: - Test doubles
  
  final class FavouritePresenterSpy : FavouritePresenterInterface {
    
    var isPresentFavouritesCalled = false
    var isPresentDeletedFavouriteCalled = false
    var response: Favourite.FavMobiles.Response?
    
    func presentFavourites(response: Favourite.FavMobiles.Response) {
      isPresentFavouritesCalled = true
      self.response = response
    }
    
    func presentDeletedFavourite(response: Favourite.FavMobiles.Response) {
      isPresentDeletedFavouriteCalled = true
      self.response = response
    }
  }
  
  final class MobilesWorkerSpy : MobilesWorker {
    var isFetchFavouritesCalled = false
    
    override func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
      isFetchFavouritesCalled = true
      
      store.fetchFavourites { (result) in
        completion(result)
      }
    }
  }

  // MARK: - Tests

  func testLoadContentBySuccess() {
    // Given
    
    // When
    let request = Favourite.FavMobiles.Request()
    sut.loadContent(request: request)
    // Then
    XCTAssertTrue(worker.isFetchFavouritesCalled)
    XCTAssertTrue(presenter.isPresentFavouritesCalled)
  }
  
  func testLoadContentByFail() {
    // Given
    
    // When
    let request = Favourite.FavMobiles.Request()
    sut.loadContent(request: request)
    // Then
    XCTAssertTrue(worker.isFetchFavouritesCalled)
    XCTAssertTrue(presenter.isPresentFavouritesCalled)
  }
  
  func testSortContentByPriceAscending() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getFavouriteList()
    sut.favMobiles = mockUnsortedMobiles
    
    //When
    let request = Favourite.SortFavs.Request(sortingType: .priceAscending)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.favMobiles.count != 0)
    XCTAssertEqual(sut.favMobiles[0].mobile.price, 1.0)
    XCTAssertTrue(presenter.isPresentFavouritesCalled)
  }
  
  func testSortContentByPriceDescending() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getFavouriteList()
    sut.favMobiles = mockUnsortedMobiles
    
    //When
    let request = Favourite.SortFavs.Request(sortingType: .priceDescending)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.favMobiles.count != 0)
    XCTAssertEqual(sut.favMobiles[0].mobile.price, 3.0)
    XCTAssertTrue(presenter.isPresentFavouritesCalled)
  }
  
  func testSortContentByRating() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getFavouriteList()
    sut.favMobiles = mockUnsortedMobiles
    
    //When
    let request = Favourite.SortFavs.Request(sortingType: .rating)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.favMobiles.count != 0)
    XCTAssertEqual(sut.favMobiles[0].mobile.rating, 3.0)
    XCTAssertTrue(presenter.isPresentFavouritesCalled)
  }
  
  func testDeleteFavouriteSuccess() {
    //Given
    let mockFavouriteList = getFavouriteList()
    sut.favMobiles = mockFavouriteList
    ContentManager.shared.allMobiles = mockFavouriteList
    
    //When
    let request = Favourite.DeleteFav.Request(id: 1)
    sut.deleteFavourite(request: request)
    
    //Then
    XCTAssertTrue(presenter.isPresentDeletedFavouriteCalled)
    XCTAssert(sut.favMobiles.count == 2)
  }
  
  func testDeleteFavouriteWithWrongIndex() {
    //Given
    let mockFavouriteList = getFavouriteList()
    sut.favMobiles = mockFavouriteList
    ContentManager.shared.allMobiles = mockFavouriteList
    
    //When
    let request = Favourite.DeleteFav.Request(id: 4)
    sut.deleteFavourite(request: request)
    
    //Then
    XCTAssertTrue(presenter.isPresentDeletedFavouriteCalled)
    XCTAssert(sut.favMobiles.count == 3)
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
