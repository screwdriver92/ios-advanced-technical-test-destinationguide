//
//  DestinationDetailsNameView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsNameView: View {
  let name: String
  
  var body: some View {
    Text(name)
      .font(designSystemFont: .defaultLExtrabold)
  }
}

struct DestinationDetailsNameView_Previews: PreviewProvider {
    static var previews: some View {
      DestinationDetailsNameView(name: "Asie")
        .previewLayout(.sizeThatFits)
    }
}
