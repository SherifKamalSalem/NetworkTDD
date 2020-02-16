//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import UIKit

extension UIView {
  func applyShadow(shadowOffset: CGSize = .zero,
                   shadowRadius: CGFloat = 3.0) {
    layer.borderColor = UIColor(named: "borderColor")!.cgColor
    layer.borderWidth = 0.5
    layer.cornerRadius = 5.0
    layer.masksToBounds = false    
    layer.shadowOffset = shadowOffset
    layer.shadowOpacity = 0.6
    layer.shadowRadius = shadowRadius
  }
}
