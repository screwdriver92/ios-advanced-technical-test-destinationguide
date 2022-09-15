//
//  UserDefaultsStoreTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre BJT on 15/09/2022.
//

import XCTest
@testable import DestinationGuide

//[✅] On init the store is empty
//[ ] Update add all destination to the store
//[ ] Delete the store remove all persisted destination
//[ ] Get destination in the right order

class UserDefaultsDestinationStore {
  func getDestinations() -> [Destination] {
    return []
  }
}

class UserDefaultsDestinationsStoreTests: XCTestCase {

  func test_getDestinations_persistDestinations() {
    let sut = UserDefaultsDestinationStore()
    
    let destinations = sut.getDestinations()
    
    XCTAssertTrue(destinations.isEmpty)
  }

}
