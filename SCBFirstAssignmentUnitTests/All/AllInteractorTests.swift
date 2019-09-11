//
//  AllInteractorTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 5/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

enum MobileError : Error {
  case fail
}

class AllInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: AllInteractor!
  var presenter : AllPresenterSpy!
  var worker : MobilesWorkerSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupAllInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupAllInteractor() {
    sut = AllInteractor()
    presenter = AllPresenterSpy()
    worker = MobilesWorkerSpy(store: MobilesMockStore())
    sut.presenter = presenter
    sut.worker = worker
  }
  
  final class AllPresenterSpy : AllPresenterInterface {
    
    var isPresentMobilesCalled = false
    var response: All.FetchMobiles.Response?
    
    func presentMobiles(response: All.FetchMobiles.Response) {
      isPresentMobilesCalled = true
      self.response = response
    }
  }
  
  final class MobilesWorkerSpy : MobilesWorker {
    
    var isFetchMobilesCalled = false
    var shouldFail = false
    
    override func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
      isFetchMobilesCalled = true
    
      if shouldFail {
        completion(.failure(MobileError.fail))
      } else {
        store.fetchMobiles { (result) in
          completion(result)
        }
      }
    }
  }
  
  // MARK: - Tests
  
  func testSortContentByPriceAscending() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getMobileList()
    sut.mobiles = mockUnsortedMobiles
    
    //When
    let request = All.SortMobiles.Request(sortingType: .priceAscending)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.mobiles.count != 0)
    XCTAssertEqual(sut.mobiles[0].mobile.price, 1.0)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testSortContentByPriceDescending() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getMobileList()
    sut.mobiles = mockUnsortedMobiles
    
    //When
    let request = All.SortMobiles.Request(sortingType: .priceDescending)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.mobiles.count != 0)
    XCTAssertEqual(sut.mobiles[0].mobile.price, 3.0)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testSortContentByRating() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getMobileList()
    
    sut.mobiles = mockUnsortedMobiles
    
    //When
    let request = All.SortMobiles.Request(sortingType: .rating)
    sut.sortContent(request: request)
    
    //Then
    XCTAssertTrue(sut.mobiles.count != 0)
    XCTAssertEqual(sut.mobiles[0].mobile.rating, 3.0)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testLoadContentByFailCase() {
    //Given
    worker.shouldFail = true
    
    //When
    let reqeust = All.FetchMobiles.Request()
    sut.loadContent(request: reqeust)
    
    //Then
    XCTAssertTrue(worker.isFetchMobilesCalled)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testLoadContentBySuccessCase() {
    //Given
    worker.shouldFail = false
    
    //When
    let reqeust = All.FetchMobiles.Request()
    sut.loadContent(request: reqeust)
    
    //Then
    XCTAssertTrue(worker.isFetchMobilesCalled)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testUpdateFavouritesWhenNotFav() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getMobileList()
    sut.mobiles = mockUnsortedMobiles
    //When
    let request = All.UpdateFavourite.Request(id: 1)
    sut.updateFavourite(request: request)
    //Then
    XCTAssertTrue(sut.mobiles[0].isFav)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testUpdateFavouritesWhenFav() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getFavouriteList()
    sut.mobiles = mockUnsortedMobiles
    ContentManager.shared.favMobiles = getFavouriteList()
    
    //When
    let request = All.UpdateFavourite.Request(id: 1)
    sut.updateFavourite(request: request)
    //Then
    XCTAssertFalse(sut.mobiles[0].isFav)
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testUpdateFavouritesWhenNIndexNotMatch() {
    //Given
    let mockUnsortedMobiles : [Mobile] = getMobileList()
    sut.mobiles = mockUnsortedMobiles
    //When
    let request = All.UpdateFavourite.Request(id: 4)
    sut.updateFavourite(request: request)
    //Then
    XCTAssertFalse(sut.mobiles[0].isFav)
    XCTAssertFalse(presenter.isPresentMobilesCalled)
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

fileprivate func getFavouriteList() -> [Mobile] {
  return [
    Mobile(mobile: MobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: true),
    Mobile(mobile: MobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: true),
    Mobile(mobile: MobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: true)
  ]
}
