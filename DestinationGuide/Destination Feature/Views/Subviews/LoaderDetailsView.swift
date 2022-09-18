//
//  LoaderDetailsView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 19/09/2022.
//

import SwiftUI

struct LoaderDetailsView: View {
  var body: some View {
    VStack {
      ProgressView()
        .scaleEffect(4)
        .progressViewStyle(CircularProgressViewStyle(tint: .white))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.opacity(0.5))
    .edgesIgnoringSafeArea(.all)
  }
}

struct LoaderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderDetailsView()
    }
}
