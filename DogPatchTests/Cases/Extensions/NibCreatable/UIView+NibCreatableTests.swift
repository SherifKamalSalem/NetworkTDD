//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

@testable import DogPatch
import XCTest

class UIView_NibCreatableTests: XCTestCase {
  
  func test_nib_returnsExpected() throws {
    // given
    let nib = TestView.nib
    
    // when
    let view = try XCTUnwrap(nib.instantiate(withOwner: nil, options: nil).last)
    
    // then
    XCTAssertTrue(view is TestView)
  }
  
  func test_nibName_returnsExpected() {
    // given
    let expected = "\(TestView.self)"
    
    // when
    let actual = TestView.nibName
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibName_canBeOverridden() {
    // given
    let expected = "SomethingElse"
    class TestView: UIView {
      override class var nibName: String { return "SomethingElse" }
    }
    
    // when
    let actual = TestView.nibName
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibBundle_returnsExpected() {
    // given
    let expected = Bundle(for: TestView.self)
    
    // when
    let actual = TestView.nibBundle
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibBundle_canBeOverriden() {
    // given
    class TestView: UIView {
      override class var nibBundle: Bundle? { return nil }
    }
    
    // when
    let actual = TestView.nibBundle
    
    // then
    XCTAssertNil(actual)
  }
  
  func test_instanceFromNib_returnsExpected() {
    // when
    let actual = TestView.instanceFromNib() as UIView
    
    // then
    XCTAssertTrue(actual is TestView)
  }  
}
