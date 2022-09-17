//
//  DestinationDetailsViewModelSwiftUI.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import Foundation

class DestinationDetailsViewModelSwiftUI {
  @Published var isDescriptionExpended = false
  let details: DestinationDetailsSwiftUI
  
  init(details: DestinationDetailsSwiftUI) {
    self.details = details
  }
  
  func toggleDescriptionVisibity() {
    isDescriptionExpended.toggle()
  }
}
