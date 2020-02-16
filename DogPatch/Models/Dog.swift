//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import Foundation

struct Dog: Decodable, Equatable {
  
  // MARK: - Identifier Properties
  let id: String
  let sellerID: String
  
  // MARK: - Instance Properties
  let about: String
  let birthday: Date
  let breed: String
  let breederRating: Double
  let cost: Decimal
  let created: Date
  let imageURL: URL
  let name: String
}
