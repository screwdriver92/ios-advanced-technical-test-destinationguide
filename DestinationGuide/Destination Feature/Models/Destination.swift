//
//  Destination.swift
//  DestinationGuide
//
//  Created by Alexandre Guibert1 on 02/08/2021.
//

import Foundation

struct Destination : Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let picture: URL
    let tag: String?
    let rating: Int
}
