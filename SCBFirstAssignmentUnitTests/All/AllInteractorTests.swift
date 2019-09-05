//
//  AllInteractorTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 5/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

enum TestError : Error {
  case fail
}

class AllInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: AllInteractor!
  var presenter : AllPresenterSpy!
  var worker : MobilesWorkerSpy!
  
  var mockMobiles : [Mobile] = [
    Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
  ]
  
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
    worker = MobilesWorkerSpy(store: MobilesStore())
    sut.presenter = presenter
    sut.worker = worker
  }
  
  // MARK: - Tests
  
  func testSortContentByPriceAscending() {
    //Given
    let mockUnsortedMobiles : [Mobile] = mockMobiles
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
    let mockUnsortedMobiles : [Mobile] = mockMobiles
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
    let mockUnsortedMobiles : [Mobile] = mockMobiles
    
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
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testLoadContentBySuccessCase() {
    //Given
    worker.shouldFail = false
    
    //When
    let reqeust = All.FetchMobiles.Request()
    sut.loadContent(request: reqeust)
    
    //Then
    XCTAssertTrue(presenter.isPresentMobilesCalled)
  }
  
  func testUpdateFavourites() {
    
  }
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
  
  var mockResult : [Mobile] = [
    Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
  ]
  
  var mockFavourites : [Mobile] = [
    Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: true),
    Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: true),
    Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: true)
  ]
  
  var mockImage : ImageResponse = [
    PurpleImageResponse(url: "a", id: 1, mobileID: 1),
    PurpleImageResponse(url: "b", id: 2, mobileID: 1),
    PurpleImageResponse(url: "c", id: 3, mobileID: 1)]
  
  override func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    if shouldFail {
      completion(.failure(TestError.fail))
      isFetchMobilesCalled = true
    } else {
      completion(.success(mockResult))
      isFetchMobilesCalled = true
    }
  }
  
  override func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    completion(mockFavourites)
  }
  
  override func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    if shouldFail {
      completion(.failure(TestError.fail))
    } else {
      completion(.success(mockImage))
    }
  }
}


