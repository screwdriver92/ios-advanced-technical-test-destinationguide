//
//  DestinationCellView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 15/09/2022.
//

import SwiftUI

struct DestinationCellView: View {
  let url: URL?
  let title: String
  let rating: Int
  let tag: String?
  
  var body: some View {
    AsyncImage(url: url) { phase in
      if let image = phase.image {
        ZStack(alignment: .bottomLeading) {
          image
            .resizable()
          VStack(alignment: .leading, spacing: 8) {
            Text(title)
              .font(designSystemFont: .defaultLExtrabold)
            HStack(spacing: 0) {
              ForEach(0..<5) { index in
                Image(systemName: rating <= index ? "star" : "star.fill")
                  .foregroundColor(SwiftUI.Color.yellow)
              }
            }
            if let tag = tag {
              Text(tag)
                .font(designSystemFont: .defaultXsRegular)
                .padding(.horizontal, 8)
                .background(Color("incontournable"))
                .cornerRadius(4)
            }
          }
          .foregroundColor(.white)
          .offset(x: 16, y: -16)
        }
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
    .cornerRadius(16)
    .shadow(color: SwiftUI.Color.black.opacity(0.25), radius: 5, x: 0, y: 4)
  }
}

struct DestinationCellView_Previews: PreviewProvider {
  static var previews: some View {
    DestinationCellView(url: URL(string: "https://static1.evcdn.net/images/reduction/609757_w-800_h-800_q-70_m-crop.jpg"),
                        title: "Angleterre",
                        rating: 4,
                        tag: "incontournable")
    .previewLayout(.sizeThatFits)
  }
}
