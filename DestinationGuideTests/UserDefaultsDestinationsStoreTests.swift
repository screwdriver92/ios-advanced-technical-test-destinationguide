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
//[✅] Get destination in the right order
//[✅] On view model init all store destinations must be added to the recents destination section

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
  
  func test_initViewModel_setRecentsDestinationWithStore() {
    let destinations = [anyDestination(id: "1")]
    let service = DestinationFetchingService()
    let userDefaultStore = UserDefaultsDestinationStore(userDefaults: testUserDefaults())
    userDefaultStore.update(with: destinations)
    let viewModel = DestinationsViewModel(service: service, store: userDefaultStore)
    
    XCTAssertEqual(viewModel.recentsDestinations, destinations)
  }
  
  // MARK: - Helpers
  
  private func makeSUT() -> UserDefaultsDestinationStore {
    let sut = UserDefaultsDestinationStore(userDefaults: testUserDefaults())
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
  
  private func testUserDefaults() -> UserDefaults {
    guard let testUserDefaults = UserDefaults(suiteName: "test.destination.app") else {
      fatalError("Expected to create a UserDefaults object for test purpose")
    }
    return testUserDefaults
  }
}
