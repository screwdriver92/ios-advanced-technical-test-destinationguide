//
//  DestinationDetailsDescriptionView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsDescriptionView: View {
  let description: String
  @Binding var isExpended: Bool
  let onToggleExpendedTap: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(description)
        .font(designSystemFont: .defaultXsRegular)
        .lineLimit(isExpended ? 100 : 3)
        .transition(.opacity)
      Button(action: {
        onToggleExpendedTap()
      }, label: {
        Text(isExpended ? "Voir moins" : "Voir plus")
          .font(designSystemFont: .defaultXsBold)
      })
      .buttonStyle(.plain)
    }
  }
}

struct DestinationDetailsDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        DestinationDetailsDescriptionView(
          description: "Immense continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays qui continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays",
          isExpended: .constant(true), onToggleExpendedTap: {})
        .previewLayout(.sizeThatFits)
        DestinationDetailsDescriptionView(
          description: "Immense continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays qui continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays",
          isExpended: .constant(false), onToggleExpendedTap: {})
        .previewLayout(.sizeThatFits)
      }
    }
}
