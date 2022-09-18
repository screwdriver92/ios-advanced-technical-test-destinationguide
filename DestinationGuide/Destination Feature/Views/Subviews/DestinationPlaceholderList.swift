//
//  DestinationPlaceholderView.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 19/09/2022.
//

import SwiftUI

struct DestinationPlaceholderList: View {
  var body: some View {
    VStack(spacing: 32) {
      ForEach(0..<5) { _ in
        ZStack {
          RoundedRectangle(cornerRadius: 16)
            .fill(Color.primary.opacity(0.10))
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .shadow(color: SwiftUI.Color.black.opacity(0.25), radius: 5, x: 0, y: 4)
          ProgressView()
            .tint(.secondary)
            .scaleEffect(2)
        }
        
      }
    }
  }
}

struct DestinationPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationPlaceholderList()
    }
}
