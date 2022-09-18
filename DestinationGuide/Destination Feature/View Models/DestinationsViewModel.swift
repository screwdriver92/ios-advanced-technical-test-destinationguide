//
//  DestinationsViewModel.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 13/09/2022.
//

import Foundation
import Combine

protocol DestinationStore {
    func update(with destinations: [Destination])
    func getDestinations() -> [Destination]
    func deleteDestination()
}

class DestinationsViewModel: ObservableObject {
    @Published var destinations = [Destination]()
    @Published var recentsDestinations = [Destination]()
    @Published var selectedDestination: Destination? {
        didSet {
            addToRecentSection(selectedDestination)
            if let destinationId = selectedDestination?.id {
                getDestinationDetails(with: destinationId) { [weak self] in
                    self?.resetSelectedDestination()
                }
            }
        }
    }
    var destinationDetails: DestinationDetailsSwiftUI?
    @Published var isDisplayDetailsView = false
    @Published var isDisplayDestinationDetailsLoader = false
    @Published var isLoadingDestinations = false
    @Published var error: String?
    
    private func resetSelectedDestination() {
        selectedDestination = nil
    }
    
    private var service: DestinationFetchingService
    var store: DestinationStore
    private var cancellables = Set<AnyCancellable>()
    
    init(service: DestinationFetchingService, store: DestinationStore) {
        self.service = service
        self.store = store
        getDestinations()
        recentsDestinations = store.getDestinations()
        
        $recentsDestinations
            .dropFirst(1)
            .sink(receiveValue: { [weak self] destinations in
                self?.persistToStore(destinations)
            })
            .store(in: &cancellables)
    }
    
    func updateSelectedDestination(with destination: Destination) {
        if !isDisplayDestinationDetailsLoader {
            selectedDestination = destination
        }
    }
    
    private func displayDestinationPlaceholder() {
        isLoadingDestinations = true
    }
    
    func getDestinations() {
        displayDestinationPlaceholder()
        service.getDestinations { destinations in
            DispatchQueue.main.async {
                self.destinations = Array(try! destinations.get()).sorted(by: { $0.name < $1.name })
            }
        }
    }
    
    func headerDestinationsText() -> String {
        "Toutes nos destinations"
    }
  
    func headerRecentsText() -> String {
        "Destinations récentes"
    }
    
    var isDisplayRecentSection: Bool {
        !recentsDestinations.isEmpty
    }
  
    func getDestinationDetails(with id: Destination.ID, completion: @escaping () -> Void) {
        displayDestinationDetailsLoader()
        
        service.getDestinationDetailsSwiftUI(for: id) { [weak self] result in
            self?.hideDestinationDetailsLoader()
            
            DispatchQueue.main.async {
                switch result {
                case let .success(details):
                    self?.isDisplayDetailsView = true
                    self?.destinationDetails = details
                case let .failure(error):
                    self?.error = error.localizedDescription
                }
                
                self?.resetSelectedDestination()
                completion()
            }
        }
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
    
    private func displayDestinationDetailsLoader() {
        isDisplayDestinationDetailsLoader = true
    }
    
    private func hideDestinationDetailsLoader() {
        isDisplayDestinationDetailsLoader = false
    }
    
    // UIKT
    
    func title() -> String {
        "Toutes nos destinations"
    }
    
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
