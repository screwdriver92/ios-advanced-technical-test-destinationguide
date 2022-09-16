//
//  RecentsDestinationsList.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 17/09/2022.
//

import SwiftUI

struct RecentsDestinationsList: View {
  let destinations: [Destination]
  let onDestinationTap: (Destination) -> Void
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(destinations) { destination in
          Button(action: {
            onDestinationTap(destination)
          }, label: {
            Text(destination.name)
              .font(designSystemFont: .defaultBodyBold)
              .padding(.vertical, 8)
              .padding(.horizontal, 16)
              .background(
                Capsule()
                  .strokeBorder(.black, lineWidth: 1)
              )
          })
          .buttonStyle(.plain)
        }
      }
    }
    .animation(.spring(), value: destinations)
  }
}
struct RecentsDestinationsList_Previews: PreviewProvider {
    static var previews: some View {
      RecentsDestinationsList(
        destinations: [
          .init(id: "217", name: "Barbade", picture: URL(string:"https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 5),
          .init(id: "50", name: "Arménie", picture: URL(string:"https://static1.evcdn.net/images/reduction/1544481_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 4),
          .init(id: "6", name: "Allemagne", picture: URL(string:"https://static1.evcdn.net/images/reduction/1027397_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 5),
        ],
        onDestinationTap: { _ in })
      .previewLayout(.sizeThatFits)
    }
}
