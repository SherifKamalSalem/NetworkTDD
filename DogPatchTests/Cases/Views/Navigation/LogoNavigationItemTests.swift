//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

// MARK: - Test Module
@testable import DogPatch

// MARK: - Collaborators

// MARK: - Test Support
import XCTest

class LogoNavigationItemTests: XCTestCase {
  
  // MARK: - Instance Variables
  var sut: LogoNavigationItem!
  
  // MARK: - Then
  func assertTitleViewSetToLogoImageView(line: UInt = #line) throws {
    let imageView = try XCTUnwrap(sut.titleView as? UIImageView, line: line)
    XCTAssertEqual(imageView.image, UIImage(named: "logo_dog_patch"), line: line)
  }
  
  // MARK: - Init Tests
  func test_initTitle_setsTitleView() throws {
    // when
    sut = LogoNavigationItem(title: "title")
    
    // then
    try assertTitleViewSetToLogoImageView()
  }
  
  func test_initCoder_setsTitleView() throws {
    // given
    let bundle = Bundle(for: LogoNavigationItemTests.self)
    let nib = UINib(nibName: "TestLogoNavigationBar", bundle: bundle)
    let navigationBar = try XCTUnwrap(nib.instantiate(withOwner: nil, options: nil).last as? UINavigationBar)
    
    // when
    sut = try XCTUnwrap(navigationBar.topItem as? LogoNavigationItem)
    
    // then
    try assertTitleViewSetToLogoImageView()
  }
}
