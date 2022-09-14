//
//  DestinationGuideTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre Guibert1 on 02/08/2021.
//

import XCTest
@testable import DestinationGuide

//[✅] On init recent destinations section must be empty
//[✅] On selection destination add it to the recent section
//[ ] On selection destination persist it
//[ ] If at least 1 recent destination display the section
//[ ] Maximum of 5 recent destinations
//[ ] Insert the last selected destination to the leading
//[ ] On recent destination selection push to the details view
//[ ] On recent destination selection not persiste it

class DestinationsRecentsTests: XCTestCase {
    
    func test_init_recentsDestinationsIsEmpty() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.recentsDestinations.isEmpty)
    }
    
    func test_selectedDestination_addDestinationToRecentsSection() {
        let anyDestination = Destination(id: "1", name: "A country", picture: URL(string: "https://any-url.com")!, tag: "A tag", rating: 3)
        let sut = makeSUT()
        
        sut.selectedDestination = anyDestination
        
        XCTAssertEqual(sut.recentsDestinations, [anyDestination])
    }
    
    // MARK: Helpers
    
    private func makeSUT() -> DestinationsViewModel {
        DestinationsViewModel(service: DestinationFetchingService())
    }
}
