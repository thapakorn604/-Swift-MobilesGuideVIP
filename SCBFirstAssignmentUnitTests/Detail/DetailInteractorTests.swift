//
//  DetailInteractorTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

enum DetailError : Error {
  case fail
}

class DetailInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: DetailInteractor!
  var presenter : DetailPresenterSpy!
  var worker : MobilesWorkerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupDetailInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupDetailInteractor() {
    sut = DetailInteractor()
    presenter = DetailPresenterSpy()
    worker = MobilesWorkerSpy(store: MobilesMockStore())
    sut.presenter = presenter
    sut.worker = worker
  }
  
  final class DetailPresenterSpy : DetailPresenterInterface {
    var isPresentDetailCalled = false
    var isPresentImageCalled = false
    
    func presentDetail(response: Detail.MobileDetail.Response) {
      isPresentDetailCalled = true
    }
    
    func presentImage(response: Detail.DetailImage.Response) {
      isPresentImageCalled = true
    }
  }
  
  final class MobilesWorkerSpy : MobilesWorker {
    var isFetchImagesCalled = false
    var shouldFail = false
    
    override func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
      isFetchImagesCalled = true
     
      if shouldFail {
        completion(.failure(DetailError.fail))
      } else {
        store.fetchImages(id: id) { (result) in
          completion(result)
        }
      }
    }
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetDetailSuccess() {
    // Given
    ContentManager.shared.allMobiles = getMobileList()
  
    // When
    let request = Detail.MobileDetail.Request(id: 1)
    sut.getDetail(request: request)
    // Then
    
    XCTAssertTrue(presenter.isPresentDetailCalled)
    XCTAssertEqual(sut.mobile.mobile.id, 1)
    //XCTAssertEqual(sut.mobile.isFav, false)
  }
  
  func testGetDetailWithWrongId() {
    // Given
    ContentManager.shared.allMobiles = getMobileList()
    let empty = Mobile()
    // When
    let request = Detail.MobileDetail.Request(id: 4)
    sut.getDetail(request: request)
    // Then
    
    XCTAssertTrue(presenter.isPresentDetailCalled)
    XCTAssertEqual(sut.mobile, empty)
  }
  
  func testGetImageWithSuccessCase() {
    // Given
    worker.shouldFail = false
    // When
    let request = Detail.DetailImage.Request(id: 1)
    sut.getImages(request: request)
    // Then
    
    XCTAssertTrue(worker.isFetchImagesCalled)
    XCTAssertTrue(presenter.isPresentImageCalled)
  }
  
  func testGetImageWithFailCase() {
    // Given
    worker.shouldFail = true
    // When
    let request = Detail.DetailImage.Request(id: 1)
    sut.getImages(request: request)
    // Then
    
    XCTAssertTrue(worker.isFetchImagesCalled)
    XCTAssertTrue(presenter.isPresentImageCalled)
  }
}


fileprivate func getMobileList() -> [Mobile] {
  return [
    Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
           isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
    Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
  ]
}

