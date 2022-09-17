//
//  DestinationDetailsSwiftUI.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import Foundation

struct DestinationDetailsSwiftUI: Identifiable, Equatable {
  let id: String
  let name: String
  let url: URL
  let tag: String
  let description: String
  let circuits: [Circuit]
  
  struct Circuit {
    let description: String
    let url: URL
  }

  static func == (lhs: DestinationDetailsSwiftUI, rhs: DestinationDetailsSwiftUI) -> Bool {
    lhs.id == rhs.id
  }
}
