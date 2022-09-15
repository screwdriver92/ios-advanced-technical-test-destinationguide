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
//[✅] Insert the last selected destination as the first element
//[✅] On recent destination selection push to the details view
//[ ] On recent destination selection not add it to the recent section
//[ ] On recent destination selection not persist it in store


class DestinationsRecentsTests: XCTestCase {
    
    func test_init_recentsDestinationsIsEmpty() {
        let (sut, _) = makeSUT()
        
        XCTAssertTrue(sut.recentsDestinations.isEmpty)
    }
    
    func test_selectedDestination_addDestinationToRecentsSection() {
        let selectedDestination = anyDestination1()
        let (sut, _) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertEqual(sut.recentsDestinations, [selectedDestination])
    }
    
    func test_selectedDestination_persistDestinationToTheStore() {
        let selectedDestination = anyDestination1()
        let (sut, store) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertEqual(store.messages, [.add(selectedDestination)])
    }
    
    func test_isDisplayRecentSection_displayRecentSectionIfAtLeastOneDestination() {
        let selectedDestination = anyDestination1()
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayRecentSection(), "Precondition - the section is hidden, no destination has been selected yet")
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertTrue(sut.isDisplayRecentSection(), "Expected to display the recent section after a destination selection")
    }
    
    func test_selectedDestination_maximumOfFiveRecentsDestinations() {
        let (sut, _) = makeSUT()
        
        sut.selectedDestination = anyDestination1()
        sut.selectedDestination = anyDestination2()
        sut.selectedDestination = anyDestination3()
        sut.selectedDestination = anyDestination4()
        sut.selectedDestination = anyDestination5()
        sut.selectedDestination = anyDestination6()
        
        XCTAssertEqual(sut.recentsDestinations.count, 5)
    }
    
    func test_selectedDestination_insertLastSelectedDestinationaAsTheFirstElement() {
        let selectedDestination = anyDestination1()
        let lastSelectedDestination = anyDestination2()
        let (sut, _) = makeSUT()
        
        sut.selectedDestination = selectedDestination
        sut.selectedDestination = lastSelectedDestination
        
        XCTAssertEqual(sut.recentsDestinations, [lastSelectedDestination, selectedDestination])
    }
    
    func test_selectedDestination_displayDestinationDetailsView() {
        let selectedDestination = anyDestination1()
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isDisplayDetailsView, "Precondition - the selected destination is nil on init, nothing to display")
        
        sut.selectedDestination = selectedDestination
        
        XCTAssertTrue(sut.isDisplayDetailsView, "Expected to display destination details view on destination selection")
    }
        
    // MARK: Helpers
    
    private func makeSUT() -> (sut: DestinationsViewModel, store: DestinationStore) {
        let store = DestinationStore()
        let sut = DestinationsViewModel(service: DestinationFetchingService(), store: store)
        return (sut, store)
    }
    
    private func anyDestination1() -> Destination {
        Destination(id: "1", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private func anyDestination2() -> Destination {
        Destination(id: "2", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private func anyDestination3() -> Destination {
        Destination(id: "3", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private func anyDestination4() -> Destination {
        Destination(id: "4", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private func anyDestination5() -> Destination {
        Destination(id: "5", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
    
    private func anyDestination6() -> Destination {
        Destination(id: "6", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
    }
}
