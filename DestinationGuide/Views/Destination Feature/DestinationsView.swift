//
//  DestinationsView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 14/09/2022.
//

import SwiftUI

struct DestinationsView: View {
  @ObservedObject var viewModel: DestinationsViewModel
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        Text("Delete UserDefaults")
          .onTapGesture {
            viewModel.recentsDestinations = []
            viewModel.store.deleteDestination()
          }
        VStack(alignment: .leading, spacing: 54) {
          if viewModel.isDisplayRecentSection {
            VStack(alignment: .leading, spacing: 12) {
              DestinationHeader(text: viewModel.headerRecentsText())
              RecentsDestinationsList(
                destinations: viewModel.recentsDestinations,
                onDestinationTap: { destination in
                  viewModel.selectedDestination = destination
                })
            }
          }
          VStack(alignment: .leading, spacing: 16) {
            DestinationHeader(text: viewModel.headerDestinationsText())
            DestinationsList(
              destinations: viewModel.destinations,
              onDestinationTap: { destination in
                viewModel.selectedDestination = destination
            })
          }
        }
      }
      .padding(.horizontal, 16)
      .navigationTitle("Destination")
      .navigationBarTitleDisplayMode(.inline)
      .animation(.spring(), value: viewModel.isDisplayRecentSection)
    }
  }
}

struct DestinationsView_Previews: PreviewProvider {
  static var previews: some View {
      DestinationsView(viewModel: DestinationsViewModel(service: DestinationFetchingService(), store: UserDefaultsDestinationStore()))
  }
}

