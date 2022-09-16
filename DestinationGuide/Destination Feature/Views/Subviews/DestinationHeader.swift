//
//  DestinationHeader.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 14/09/2022.
//

import SwiftUI

struct DestinationHeader: View {
  let text: String
  
  var body: some View {
    Text(text)
      .font(designSystemFont: .defaultMExtrabold)
  }
}

struct DestinationHeader_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        DestinationHeader(text: "Toutes nos destinations")
        DestinationHeader(text: "Toutes nos destinations")
          .preferredColorScheme(.dark)
      }
      .previewLayout(.sizeThatFits)
    }
}
