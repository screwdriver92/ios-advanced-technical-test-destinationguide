//
//  UserDefaultsDestinationStore.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 16/09/2022.
//

import Foundation

class UserDefaultsDestinationStore: DestinationStore {
  
  private let userDefaults: UserDefaults
  private let recentsDestinationsKey = "recentsDestinations"
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  func getDestinations() -> [Destination] {
    if let data = userDefaults.data(forKey: recentsDestinationsKey) {
      do {
        let destinations = try JSONDecoder().decode([Destination].self, from: data)
        return destinations
      } catch {
        assertionFailure("Unable to Decode destinations (\(error))")
        return []
      }
    } else {
      return []
    }
  }
  
  func update(with destinations: [Destination]) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(destinations)
        userDefaults.set(data, forKey: recentsDestinationsKey)
    } catch {
        assertionFailure("Unable to Encode Array of destinations error (\(error))")
    }
  }
  
  func deleteDestination() {
    update(with: [])
  }
}
