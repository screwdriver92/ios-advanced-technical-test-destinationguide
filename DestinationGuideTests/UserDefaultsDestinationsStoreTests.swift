//
//  UserDefaultsStoreTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre BJT on 15/09/2022.
//

import XCTest
@testable import DestinationGuide

//[✅] On init the store is empty
//[✅] Update add all destination to the store
//[✅] Delete the store remove all persisted destination
//[ ] Get destination in the right order

class UserDefaultsDestinationStore: DestinationStore {
  private let recentsDestinationsKey = "recentsDestinations"
  
  func getDestinations() -> [Destination] {
    if let data = UserDefaults.standard.data(forKey: recentsDestinationsKey) {
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
        UserDefaults.standard.set(data, forKey: recentsDestinationsKey)

    } catch {
        assertionFailure("Unable to Encode Array of destinations error (\(error))")
    }
  }
  
  func deleteDestination() {
    update(with: [])
  }
}

class UserDefaultsDestinationsStoreTests: XCTestCase {

  func test_init_storeIsEmpty() {
    let sut = makeSUT()
    
    let destinations = sut.getDestinations()
    
    XCTAssertTrue(destinations.isEmpty)
  }
  
  func test_update_addDestinationsToTheStore() {
    let expectedDestinations = [anyDestination(id: "1"), anyDestination(id: "2")]
    let sut = makeSUT()
    
    sut.update(with: expectedDestinations)
    let destinations = sut.getDestinations()
    
    XCTAssertEqual(destinations, expectedDestinations)
  }
  
  func test_deleteDestination_deleteAllDestinationsFromTheStore() {
    let destinations = [anyDestination(id: "1")]
    let sut = makeSUT()
    
    sut.update(with: destinations)
    sut.deleteDestination()
    let storeDestinations = sut.getDestinations()
    
    XCTAssertTrue(storeDestinations.isEmpty)
  }
  
  // MARK: - Helpers
  
  private func makeSUT() -> UserDefaultsDestinationStore {
    let sut = UserDefaultsDestinationStore()
    resetStoreToDefaults(with: sut)
    return sut
  }
  
  private func resetStoreToDefaults(with sut: UserDefaultsDestinationStore) {
    addTeardownBlock {
      sut.deleteDestination()
    }
  }
  
  private func anyDestination(id: String) -> Destination {
      Destination(id: id, name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
  }

}
