//
//  DestinationsList.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 14/09/2022.
//

import SwiftUI

struct DestinationsList: View {
  let destinations: [Destination]
  let onDestinationTap: (Destination) -> Void
  
  var body: some View {
    LazyVStack(spacing: 32) {
      ForEach(destinations) { destination in
        DestinationCellView(
          url: destination.picture,
          title: destination.name,
          rating: destination.rating,
          tag: destination.tag
        )
        .onTapGesture {
          onDestinationTap(destination)
        }
      }
    }
  }
}

struct DestinationsList_Previews: PreviewProvider {
    static var previews: some View {
      DestinationsList(destinations: [
        .init(id: "217", name: "Barbade", picture: URL(string:"https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 5),
        .init(id: "50", name: "Arménie", picture: URL(string:"https://static1.evcdn.net/images/reduction/1544481_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 4),
        .init(id: "6", name: "Allemagne", picture: URL(string:"https://static1.evcdn.net/images/reduction/1027397_w-800_h-800_q-70_m-crop.jpg")!, tag: "Incontournable", rating: 5),
      ], onDestinationTap: {_ in })
    }
}
