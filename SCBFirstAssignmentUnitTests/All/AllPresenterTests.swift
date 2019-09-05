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
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
