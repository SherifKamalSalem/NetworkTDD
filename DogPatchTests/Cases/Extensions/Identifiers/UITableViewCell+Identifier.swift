//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

@testable import DogPatch
import XCTest

class UITableViewCell_Identifier: XCTestCase {
  
  func test_identifer_returnsExpected() {
    // given
    let expected = "\(TestTableViewCell.self)"
    
    // when
    let actual = TestTableViewCell.identifier
    
    // then
    XCTAssertEqual(actual, expected)
  }
}
