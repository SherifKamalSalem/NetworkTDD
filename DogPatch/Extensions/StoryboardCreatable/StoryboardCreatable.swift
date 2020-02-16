//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import UIKit

protocol StoryboardCreatable: class {
  static var storyboard: UIStoryboard { get }
  static var storyboardBundle: Bundle? { get }
  static var storyboardIdentifier: String { get }
  static var storyboardName: String { get }
  
  static func instanceFromStoryboard() -> Self
}

