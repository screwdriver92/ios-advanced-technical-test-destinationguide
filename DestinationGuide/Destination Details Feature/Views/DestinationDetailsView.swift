//
//  DestinationDetailsView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 17/09/2022.
//

import SwiftUI

struct DestinationDetailsView: View {
  @ObservedObject var viewModel: DestinationDetailsViewModelSwiftUI
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 27) {
        DestinationDetailsImageView(url: viewModel.details.url)
        VStack(alignment: .leading, spacing: 16) {
          DestinationDetailsTagView(tag: viewModel.details.tag)
          DestinationDetailsNameView(name: viewModel.details.name)
          DestinationDetailsDescriptionView(
            description: viewModel.details.description,
            isExpended: $viewModel.isDescriptionExpended,
            onToggleExpendedTap: {
              viewModel.toggleDescriptionVisibity()
            })
        }
        .padding(.horizontal, 16)
        VStack(alignment: .leading, spacing: 16) {
          DestinationDetailsHeaderCircuitsView(text: "Idée de circuits")
          DestinationDetailsCircuitsList(circuits: viewModel.details.circuits)
        }
        Spacer()
      }
    }
    .animation(.default, value: viewModel.isDescriptionExpended)
    .navigationTitle(viewModel.details.name)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct DestinationDetailsView_Previews: PreviewProvider {
  static var imageURL = URL(string: "https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!
  
  static var previews: some View {
    DestinationDetailsView(
      viewModel: .init(details: DestinationDetailsSwiftUI(
        id: "1",
        name: "Asie",
        url: imageURL,
        tag: "incontournable",
        description: "Immense continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays qui continent aux portes de l’Europe, l’Asie recèle bien des trésors. L’Inde, la Chine, le Vietnam, le Japon, tant de pays",
        circuits: [
          .init(description: "Splendeurs khmères d'Angkor au Tonle Sap",
                url: imageURL),
          .init(description: "De la montagne du Vietnam au delta du Cambodge",
                url: imageURL),
          .init(description: "Le festival de Jakar en petit groupe",
                url: imageURL)
        ])
      )
    )
  }
}
