//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import Foundation

struct User: Decodable, Equatable {
  
  // MARK: - Identifier Properties
  let id: String
  
  // MARK: - Instance Properties
  let about: String?
  let email: String
  let name: String
  let profileImageURL: URL?
  let reviewCount: UInt
  let reviewRatingAverage: Double
}
