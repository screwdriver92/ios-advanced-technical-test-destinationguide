//
//  DestinationsViewModel.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 13/09/2022.
//

import Foundation

protocol DestinationStore {
    func update(with destinations: [Destination])
    func getDestinations() -> [Destination] 
}

class DestinationsViewModel: ObservableObject {
    @Published var destinations = [Destination]()
    @Published var recentsDestinations = [Destination]() {
        didSet { persistToStore(recentsDestinations) }
    }
    @Published var selectedDestination: Destination? {
        didSet {
            addToRecentSection(selectedDestination)
            displayDetailsViewIfNeeded()
        }
    }
    @Published var isDisplayDetailsView = false
    @Published var error: String?
    
    private var service: DestinationFetchingService
    private var store: DestinationStore
    
    init(service: DestinationFetchingService, store: DestinationStore) {
        self.service = service
        self.store = store
        getDestinations()
        recentsDestinations = store.getDestinations()
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
    
    private func displayDetailsViewIfNeeded() {
        isDisplayDetailsView = selectedDestination == nil ? false : true
    }
    
    private func addToRecentSection(_ destination: Destination?) {
        if let destination = destination {
            guard !recentsDestinations.contains(destination) else { return }
            if recentsDestinations.count >= 5 {
                _ = recentsDestinations.popLast()
            }
            recentsDestinations.insert(destination, at: 0)
        }
    }
    
    private func persistToStore(_ destinations: [Destination]) {
//        if let destination = destination {
//            guard !recentsDestinations.contains(destination) else { return }
        store.update(with: destinations)
//        }
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
