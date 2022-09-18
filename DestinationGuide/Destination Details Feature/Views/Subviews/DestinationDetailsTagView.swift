//
//  DestinationDetailsTagView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsTagView: View {
  let tag: String
  
  var body: some View {
    Text(tag)
      .font(designSystemFont: .defaultXsBold)
      .foregroundColor(SwiftUI.Color.white)
      .padding(.horizontal, 8)
      .background(Color("incontournable"))
      .cornerRadius(4)
  }
}

struct DestinationDetailsTagView_Previews: PreviewProvider {
    static var previews: some View {
      DestinationDetailsTagView(tag: "incontournable")
        .previewLayout(.sizeThatFits)
    }
}
