//
//  DestinationGuideTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre Guibert1 on 02/08/2021.
//

import XCTest
@testable import DestinationGuide
import SwiftUI

//[✅] On init recent destinations section must be empty
//[✅] On selection destination add it to the recent section
//[✅] On selection destination persist it to the store
//[✅] If at least 1 recent destination display the corresponding section
//[✅] Maximum of 5 recent destinations
//[ ] Insert the last selected destination to the leading
//[ ] On recent destination selection push to the details view
//[ ] On recent destination selection not persiste it


class DestinationsRecentsTests: XCTestCase {
    
    func test_init_recentsDestinationsIsEmpty() {
        let (sut, _) = makeSUT()
        
        XCTAssertTrue(sut.recentsDestinations.isEmpty)
    }
    
    func test_selectedDestination_addDestinationToRecentsSection() {
        let selectedDestination = anyDestination()
        let (sut, _) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertEqual(sut.recentsDestinations, [selectedDestination])
    }
    
    func test_selectedDestination_persistDestinationToTheStore() {
        let selectedDestination = anyDestination()
        let (sut, store) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertEqual(store.messages, [.add(selectedDestination)])
    }
    
    func test_isDisplayRecentSection_displayRecentSectionIfAtLeastOneDestination() {
        let selectedDestination = anyDestination()
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayRecentSection(), "Precondition - the section is hidden, no destination has been selected yet")
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertTrue(sut.isDisplayRecentSection(), "Expected to display the recent section after a destination selection")
    }
    
    func test_selectedDestination_maximumOfFiveRecentsDestinations() {
        let selectedDestination = anyDestination()
        let (sut, _) = makeSUT()
        
        (1...6).forEach { _ in
            sut.selectedDestination = selectedDestination
        }
        
        XCTAssertEqual(sut.recentsDestinations.count, 5)
    }

        
    // MARK: Helpers
    
    private func makeSUT() -> (sut: DestinationsViewModel, store: DestinationStore) {
        let store = DestinationStore()
        let sut = DestinationsViewModel(service: DestinationFetchingService(), store: store)
        return (sut, store)
    }
    
    private func anyDestination() -> Destination {
        Destination(id: "1", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
}
