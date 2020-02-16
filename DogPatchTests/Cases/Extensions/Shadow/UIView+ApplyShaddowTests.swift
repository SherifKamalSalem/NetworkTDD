//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

@testable import DogPatch
import XCTest

class UIView_ApplyShaddowTests: XCTestCase {
  
  // MARK: - Instance Properties
  var sut: UIView!
  
  // MARK: - Test Lifecycle
  override func setUp() {
    super.setUp()
    sut = UIView()
  }
  
  // MARK: - Tests
  func test_applyShadow_setsBorderColor() throws {
    // given
    sut.layer.borderColor = nil
    
    // when
    sut.applyShadow()
    
    // then
    XCTAssertNotNil(sut.layer.borderColor)
  }
  
  func test_applyShadow_setsBorderWidth() {
    // given
    sut.layer.borderWidth = 0.0
    
    // when
    sut.applyShadow()
    
    // then
    XCTAssertGreaterThan(sut.layer.borderWidth, 0.0)
  }
  
  func test_applyShaddow_setsMasksToBounds() {
    // given
    sut.layer.masksToBounds = true
    
    // when
    sut.applyShadow()
    
    // then
    XCTAssertFalse(sut.layer.masksToBounds)
  }
  
  func test_applyShadow_setsShadowOffset() {
    // given
    let expected = CGSize(width: 3.0, height: 3.0)
    sut.layer.shadowOffset = CGSize(width: 42.0, height: 42.0)
    
    // when
    sut.applyShadow(shadowOffset: expected)
    let actual = sut.layer.shadowOffset
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_applyShadow_setsShadowOpacity() {
    // given
    sut.layer.shadowOpacity = 0.0
    
    // when
    sut.applyShadow()
    
    // then
    XCTAssertGreaterThan(sut.layer.shadowOpacity, 0.0)
  }
  
  func test_applyShadow_setsShadowRadius() {
    // given
    let expected: CGFloat = 5.0
    sut.layer.shadowRadius = 42.0
    
    // when
    sut.applyShadow(shadowRadius: expected)
    let actual = sut.layer.shadowRadius
    
    // then
    XCTAssertEqual(actual, expected)
  }
}
