//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import UIKit

protocol NibCreatable: class {
  
  static var nib: UINib { get }
  static var nibBundle: Bundle? { get }
  static var nibName: String { get }
  
  static func instanceFromNib() -> Self
}
