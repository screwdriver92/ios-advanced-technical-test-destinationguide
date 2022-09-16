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
        VStack(alignment: .leading, spacing: 16) {
          DestinationHeader(text: viewModel.title())
          DestinationsList(destinations: viewModel.destinations)
        }
      }
      .padding(16)
      .navigationTitle("Destination")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct DestinationsView_Previews: PreviewProvider {
  static var previews: some View {
      DestinationsView(viewModel: DestinationsViewModel(service: DestinationFetchingService(), store: UserDefaultsDestinationStore()))
  }
}

