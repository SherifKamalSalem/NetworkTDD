//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

@testable import DogPatch
import XCTest

class UIViewController_NibCreatableTests: XCTestCase {
  
  func test_nib_returnsExpected() throws {
    // given
    let nib = TestViewController.nib
    
    // when
    let view = nib.instantiate(withOwner: nil, options: nil).last
    
    // then
    XCTAssertNotNil(view)
  }
  
  func test_nibName_returnsExpected() {
    // given
    let expected = "\(TestViewController.self)"
    
    // when
    let actual = TestViewController.nibName
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibName_canBeOverriden() {
    // given
    let expected = "SomethingElse"
    class TestViewController: UIViewController {
      override class var nibName: String { return "SomethingElse" }
    }
    
    // when
    let actual = TestViewController.nibName
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibBundle_returnsExpected() {
    // given
    let expected = Bundle(for: TestViewController.self)
    
    // when
    let actual = TestViewController.nibBundle
    
    // then
    XCTAssertEqual(actual, expected)
  }
  
  func test_nibBundle_canBeOverridden() {
    // given
    class TestViewController: UIViewController {
      override class var nibBundle: Bundle? { return nil }
    }
    
    // when
    let actual = TestViewController.nibBundle
    
    // then
    XCTAssertNil(actual)
  }
  
  func test_instanceFromNib_returnsExpected() {
    // when
    let actual = TestViewController.instanceFromNib() as UIViewController
    
    // then    
    XCTAssertTrue(actual is TestViewController)
  }
}
