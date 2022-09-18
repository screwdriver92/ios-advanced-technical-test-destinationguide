//
//  DestinationDetailsHeaderCircuitsView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsHeaderCircuitsView: View {
  let text: String
  
  var body: some View {
    Text(text)
      .padding(.leading, 16)
      .font(designSystemFont: .defaultMExtrabold)
  }
}

struct DestinationDetailsHeaderCircuitsView_Previews: PreviewProvider {
    static var previews: some View {
      DestinationDetailsHeaderCircuitsView(text: "Idée de circuits")
        .previewLayout(.sizeThatFits)
    }
}
