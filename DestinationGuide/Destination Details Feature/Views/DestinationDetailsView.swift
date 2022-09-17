//
//  DestinationDetailsView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 17/09/2022.
//

import SwiftUI

struct DestinationDetailsView: View {
  let viewModel: DestinationDetailsViewModelSwiftUI
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 27) {
        AsyncImage(url: viewModel.details.url) { phase in
          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(height: 280)
              .clipped()
          } else if phase.error != nil {
            Color.red
              .frame(maxWidth: .infinity)
              .frame(height: 280)
          } else {
            ProgressView()
              .tint(.secondary)
              .scaleEffect(2)
          }
        }
        .frame(height: 280)
        .frame(maxWidth: .infinity)
        .background(Color.primary.opacity(0.10))
        VStack(alignment: .leading, spacing: 16) {
          Text(viewModel.details.tag)
            .font(designSystemFont: .defaultXsBold)
            .foregroundColor(SwiftUI.Color.white)
            .padding(.horizontal, 8)
            .background(Color("incontournable"))
            .cornerRadius(4)
          Text(viewModel.details.name)
            .font(designSystemFont: .defaultLExtrabold)
          VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.details.description)
              .font(designSystemFont: .defaultXsRegular)
              .lineLimit(viewModel.isDescriptionExpended ? 100 : 3)
              .transition(.opacity)
            Button(action: {
              viewModel.toggleDescriptionVisibity()
            }, label: {
              Text(viewModel.isDescriptionExpended ? "Voir moins" : "Voir plus")
                .font(designSystemFont: .defaultXsBold)
            })
            .buttonStyle(.plain)
          }
        }
        .padding(.horizontal, 16)
        VStack(alignment: .leading, spacing: 16) {
          Text("Idée de circuits")
            .padding(.leading, 16)
            .font(designSystemFont: .defaultMExtrabold)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
              Color.clear.frame(width: 0)
              ForEach(viewModel.details.circuits, id: \.description) { circuit in
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
