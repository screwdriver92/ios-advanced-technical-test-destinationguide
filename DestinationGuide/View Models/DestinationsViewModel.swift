//
//  DestinationsViewModel.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 13/09/2022.
//

import Foundation

class DestinationStore {
    enum Message: Equatable {
        case add(Destination)
    }
    
    private(set) var messages = [Message]()
    
    func add(_ destination: Destination) {
        messages.append(.add(destination))
    }
}

class DestinationsViewModel: ObservableObject {
    @Published var destinations = [Destination]()
    @Published var recentsDestinations = [Destination]()
    @Published var selectedDestination: Destination? {
        didSet {
            addToRecentSection(selectedDestination)
            persistToStore(selectedDestination)
        }
    }
    @Published var error: String?
    
    private var service: DestinationFetchingService
    private var store: DestinationStore
    
    init(service: DestinationFetchingService, store: DestinationStore) {
        self.service = service
        self.store = store
        getDestinations()
    }
    
    func getDestinations() {
        service.getDestinations { destinations in
            self.destinations = Array(try! destinations.get()).sorted(by: { $0.name < $1.name })
        }
    }
    
    func title() -> String {
        "Toutes nos destinations"
    }
    
    func isDisplayRecentSection() -> Bool {
        !recentsDestinations.isEmpty
    }
        
//    func getDestinationDetails(with id: Destination.ID) {
//        service.getDestinationDetails(for: id) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case let .success(details):
//                    self.selectedDestination = details
//                case let .failure(error):
//                    self.error = error.localizedDescription
//                }
//            }
//
//        }
//    }

    // MARK: - Helpers
    private func addToRecentSection(_ destination: Destination?) {
        if let destination = destination {
            recentsDestinations.append(destination)
        }
    }
    
    private func persistToStore(_ destination: Destination?) {
        if let destination = destination {
            store.add(destination)
        }
    }
    
    // UIKT
    
    func numberOfItems() -> Int {
        destinations.count
    }
    
    func destination(for index: Int) -> Destination {
        destinations[index]
    }
    
    func alertTitle() -> String{
        "Erreur"
    }
    
    func alertActionTitle() -> String {
        "Annuler"
    }
}
