//
//  DestinationDetailsViewModel.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 13/09/2022.
//

import Foundation

class DestinationDetailsViewModel {
    let name: String
    let webviewUrl: URL

    init(title: String, webviewUrl: URL) {
        self.name = title
        self.webviewUrl = webviewUrl
    }
    
    func request() -> URLRequest {
        URLRequest(url: webviewUrl)
    }
}


