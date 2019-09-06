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
  }

  final class DetailViewControllerSpy : DetailViewControllerInterface {
    var isDisplayDetailCalled = false
    var isDisplayImageCalled = false
    var displayedImages : [Detail.DetailImage.ViewModel.displayedImage] = []
    var errorMsg = ""
    
    func displayDetail(viewModel: Detail.MobileDetail.ViewModel) {
      
    }
    
    func displayImage(viewModel: Detail.DetailImage.ViewModel) {
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

  func testSomething() {
    // Given

    // When

    // Then
  }
}
