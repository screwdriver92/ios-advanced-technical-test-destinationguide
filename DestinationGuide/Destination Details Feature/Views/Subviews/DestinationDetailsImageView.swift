//
//  DestinationDetailsImageView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 18/09/2022.
//

import SwiftUI

struct DestinationDetailsImageView: View {
  let url: URL
  
  var body: some View {
    AsyncImage(url: url) { phase in
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
  }
}

struct DestinationDetailsImageView_Previews: PreviewProvider {
  static var previews: some View {
    DestinationDetailsImageView(url: URL(string: "https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!)
      .previewLayout(.sizeThatFits)
  }
}
