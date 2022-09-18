//
//  DestinationDetailsCircuitsList.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsCircuitsList: View {
  let circuits: [DestinationDetailsSwiftUI.Circuit]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 16) {
        Color.clear.frame(width: 0)
        ForEach(circuits, id: \.description) { circuit in
          VStack {
            AsyncImage(url: circuit.url) { phase in
              if let image = phase.image {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 144, height: 166)
              } else if phase.error != nil {
                Color.red
                  .frame(maxWidth: .infinity)
                  .frame(height: 166)
              } else {
                ProgressView()
                  .tint(.secondary)
                  .scaleEffect(2)
              }
            }
            .frame(height: 166)
            .frame(maxWidth: .infinity)
            .background(Color.primary.opacity(0.10))
            .cornerRadius(8)
            
            Text(circuit.description)
              .font(designSystemFont: .defaultXsBold)
          }
          .frame(width: 144)
        }
        Color.clear.frame(width: 0)
      }
    }
  }
}

struct DestinationDetailsCircuitsList_Previews: PreviewProvider {
  static let imageURL = URL(string: "https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!
  
  static var previews: some View {
    DestinationDetailsCircuitsList(
      circuits: [
        .init(description: "Splendeurs khmères d'Angkor au Tonle Sap",
              url: imageURL),
        .init(description: "De la montagne du Vietnam au delta du Cambodge",
              url: imageURL),
        .init(description: "Le festival de Jakar en petit groupe",
              url: imageURL)
      ])
    .previewLayout(.sizeThatFits)
  }
}
