//
//  DetailPresenterTests.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import SCBFirstAssignment
import XCTest

class DetailPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: DetailPresenter!
  var viewController : DetailViewControllerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupDetailPresenter() {
    sut = DetailPresenter()
    viewController = DetailViewControllerSpy()
    sut.viewController = viewController
  }

  final class DetailViewControllerSpy : DetailViewControllerInterface {
    var isDisplayDetailCalled = false
    var isDisplayImageCalled = false
    var displayedMobile : Detail.MobileDetail.ViewModel?
    var displayedImages : [Detail.DetailImage.ViewModel.displayedImage] = []
    var errorMsg = ""
    
    func displayDetail(viewModel: Detail.MobileDetail.ViewModel) {
      isDisplayDetailCalled = true
      displayedMobile = viewModel
    }
    
    func displayImage(viewModel: Detail.DetailImage.ViewModel) {
      isDisplayImageCalled = true
      switch viewModel.displayedImages {
      case .success(let images):
        displayedImages = images
      case .error(let error):
        errorMsg = error
      }
    }
  }
  // MARK: - Test doubles

  // MARK: - Tests

  func testPresentDetailWithCorrectFormat() {
    // Given
    let mobile = Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
                        isFav: false)
    // When
    let response = Detail.MobileDetail.Response(detailedMobile: mobile)
    sut.presentDetail(response: response)

    // Then
    XCTAssertTrue(viewController.isDisplayDetailCalled)
    
    XCTAssertEqual(viewController.displayedMobile?.price, "Price: $1.0")
    XCTAssertEqual(viewController.displayedMobile?.rating, "Rating: 1.0")
  }
  
  func testPresentDetailWithEmptyContent() {
    // Given
    let mobile = Mobile()
    // When
    let response = Detail.MobileDetail.Response(detailedMobile: mobile)
    sut.presentDetail(response: response)
    
    // Then
    XCTAssertFalse(viewController.isDisplayDetailCalled)
    XCTAssertNil(viewController.displayedMobile)
  }
  
  func testPresentImageWithSuccessCase() {
    // Given
    let content : Content<ImageResponse> = .success(data: getImages())
    // When
    let response = Detail.DetailImage.Response(content: content)
    sut.presentImage(response: response)
    
    // Then
    XCTAssertTrue(viewController.isDisplayImageCalled)
    XCTAssertEqual(viewController.displayedImages[0].imageURL, "https://a")
    XCTAssertEqual(viewController.displayedImages[1].imageURL, "https://b")
    XCTAssertEqual(viewController.displayedImages[2].imageURL, "https://c")
  }
  
  func testPresentImageWithFailCase() {
    // Given
    let errorMsg = "error message"
    let content : Content<ImageResponse> = .error(errorMsg)
    // When
    let response = Detail.DetailImage.Response(content: content)
    sut.presentImage(response: response)
    
    // Then
    XCTAssertTrue(viewController.isDisplayImageCalled)
    XCTAssertEqual(viewController.errorMsg, errorMsg)
  }
  
  func testPresentImageWithEmptyContent() {
    // Given
    let empty : ImageResponse = []
    let content : Content<ImageResponse> = .success(data: empty)
    // When
    let response = Detail.DetailImage.Response(content: content)
    sut.presentImage(response: response)
    
    // Then
    XCTAssertTrue(viewController.isDisplayImageCalled)
    XCTAssertTrue(viewController.displayedImages.count == 0)
  }
}

fileprivate func getImages () -> ImageResponse {
  return [
    PurpleImageResponse(url: "a", id: 1, mobileID: 1),
    PurpleImageResponse(url: "b", id: 2, mobileID: 1),
    PurpleImageResponse(url: "c", id: 3, mobileID: 1)]
}
