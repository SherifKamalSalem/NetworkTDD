//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import UIKit

class ErrorTableViewCell: UITableViewCell {
  @IBOutlet var containerView: UIView! {
    didSet { containerView.applyShadow() }
  }
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
}
