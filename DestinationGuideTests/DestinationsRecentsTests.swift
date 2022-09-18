//
//  DestinationGuideTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre Guibert1 on 02/08/2021.
//

import XCTest
@testable import DestinationGuide
import SwiftUI

// PERSIST DESTINATION FEATURE
//[✅] On init recent destinations section must be empty
//[✅] On selection destination add it to the recent section
//[✅] On selection destination persist it to the store
//[✅] If at least 1 recent destination display the corresponding section
//[✅] Maximum of 5 recent destinations
//[✅] Insert the last selected destination as the first element
//[✅] On recent destination selection push to the details view
//[✅] On already selected destination not add it to the recent section
//[✅] On already selected destination not persist it in store
//[✅] On store update, all destinations must be deleted before

// LOADER DESTINATION DETAILS FEATURE
//[✅] If no destination selected hide the loader
//[✅] If destination selected display the loader
//[✅] If loader is visible it's not possible to select an other destination
//[ ] On destination details push, reset the selected destination

class DestinationsRecentsTests: XCTestCase {
    // MARK: - PERSIST DESTINATION FEATURE
    
    func test_init_recentsDestinationsIsEmpty() {
        let (sut, _) = makeSUT()
        
        XCTAssertTrue(sut.recentsDestinations.isEmpty)
    }
    
    func test_selectedDestination_addDestinationToRecentsSection() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, _) = makeSUT()
        
        sut.updateSelectedDestination(with: selectedDestination)
        
        XCTAssertEqual(sut.recentsDestinations, [selectedDestination])
    }
    
    func test_selectedDestination_persistDestinationToTheStore() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, store) = makeSUT()
        
        sut.updateSelectedDestination(with: selectedDestination)
        
        XCTAssertEqual(store.messages, [.deleteAll, .update([selectedDestination])])
    }
    
    func test_isDisplayRecentSection_displayRecentSectionIfAtLeastOneDestination() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayRecentSection, "Precondition - the section is hidden, no destination has been selected yet")
        
        sut.updateSelectedDestination(with: selectedDestination)
        
        XCTAssertTrue(sut.isDisplayRecentSection, "Expected to display the recent section after a destination selection")
    }
    
    func test_selectedDestination_maximumOfFiveRecentsDestinations() {
        let (sut, _) = makeSUT()
        
        (0...6).forEach { index in
            let anyDestination = anyDestination(id: "\(index)")
            sut.selectedDestination = anyDestination
            wait(sut, toCompleteDestinationDetailsWith: anyDestination)
        }
        
        XCTAssertEqual(sut.recentsDestinations.count, 5)
    }
        
    func test_selectedDestination_insertLastSelectedDestinationaAsTheFirstElement() {
        let selectedDestination = anyDestination(id: "217")
        let lastSelectedDestination = anyDestination(id: "50")
        let (sut, _) = makeSUT()
        
        sut.updateSelectedDestination(with: selectedDestination)
        wait(sut, toCompleteDestinationDetailsWith: selectedDestination)
                
        sut.updateSelectedDestination(with: lastSelectedDestination)
        wait(sut, toCompleteDestinationDetailsWith: lastSelectedDestination)

        XCTAssertEqual(sut.recentsDestinations, [lastSelectedDestination, selectedDestination])
    }
    
    func test_selectedDestination_displayDestinationDetailsView() {
        let selectedDestination = anyDestination(id: "217")
        let expectedDestinationDetails = DestinationDetailsSwiftUI(id: "217", name: "Barbade", url: URL(string: "https://any-url.com")!, tag: "incontournable", description: "description", circuits: [])
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayDetailsView, "Precondition - the selected destination is nil on init, nothing to display")
                
        sut.updateSelectedDestination(with: selectedDestination)

        let exp = XCTestExpectation(description: "Expected the request to complete")
        sut.getDestinationDetails(with: selectedDestination.id) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        
        XCTAssertTrue(sut.isDisplayDetailsView, "Expected to display destination details view on destination selection")
        XCTAssertEqual(sut.destinationDetails, expectedDestinationDetails, "Expected to get a destination details view to display on destination selection")
    }
    
    func test_selectedDestination_doesNotAddToRecentDestinationAlreadySelectedDestination() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, _) = makeSUT()
                
        sut.updateSelectedDestination(with: selectedDestination)
        XCTAssertEqual(sut.recentsDestinations, [selectedDestination], "Expected that the recent destination has been added to the recent section on destination selection")
        
        sut.updateSelectedDestination(with: selectedDestination)
        XCTAssertEqual(sut.recentsDestinations, [selectedDestination], "Expected that the recent destination was not be added, double are not allowed")
    }
    
    func test_selectedDestination_doesNotPersistRecentDestinationAlreadySelected() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, store) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        XCTAssertEqual(store.messages, [.deleteAll, .update([selectedDestination])], "Expected that the recent destination has been persist to the store on destination selection")
        
        sut.selectedDestination = selectedDestination
        XCTAssertEqual(store.messages, [.deleteAll, .update([selectedDestination])], "Expected that the recent destination was not persist, double are not allowed")
    }
    
    // MARK: - LOADER DESTINATION DETAILS FEATURE
    
    func test_init_hideDestinationDetailsLoader() {
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayDestinationDetailsLoader)
    }

    func test_selectedDestination_displayDestinationDetailsLoader() {
        let selectedDestination = anyDestination(id: "1")
        let (sut, _) = makeSUT()
        
        sut.updateSelectedDestination(with: selectedDestination)
        
        XCTAssertTrue(sut.isDisplayDestinationDetailsLoader)
    }
    
    func test_selectedDestination_doesNotSelectOtherDestinationIfLoadingDetailsView() {
        let selectedDestination = anyDestination(id: "1")
        let otherDestination = anyDestination(id: "2")
        let (sut, _) = makeSUT()
        
        sut.updateSelectedDestination(with: selectedDestination)
        sut.updateSelectedDestination(with: otherDestination)
        
        XCTAssertEqual(sut.selectedDestination, selectedDestination)
    }
    
    // MARK: Helpers
    
    private func makeSUT() -> (sut: DestinationsViewModel, store: DestinationStoreSpy) {
        let store = DestinationStoreSpy()
        let sut = DestinationsViewModel(service: DestinationFetchingService(), store: store)
        return (sut, store)
    }
    
    private func wait(_ sut: DestinationsViewModel, toCompleteDestinationDetailsWith destination: Destination) {
        let exp = XCTestExpectation(description: "Expect that the get destination details completes")
        sut.getDestinationDetails(with: destination.id) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
        return
    }
    
    private func anyDestination(id: String) -> Destination {
        Destination(id: id, name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private class DestinationStoreSpy: DestinationStore {
        enum Message: Equatable {
            case update([Destination])
            case deleteAll
        }
        
        private(set) var messages = [Message]()
        
        func update(with destinations: [Destination]) {
            deleteAll()
            messages.append(.update(destinations))
        }
    
        func getDestinations() -> [Destination] {
            return []
        }
    
        func deleteDestination() { }
        
        // MARK: - Helpers
        
        private func deleteAll() {
            messages.append(.deleteAll)
        }
    }
}
