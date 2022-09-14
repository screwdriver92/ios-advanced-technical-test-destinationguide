//
//  DestinationsViewModel.swift
//  DestinationGuide
//
//  Created by Alexandre BJT on 13/09/2022.
//

import Foundation

class DestinationsViewModel: ObservableObject {
    @Published var destinations = [Destination]()
    @Published var recentsDestinations = [Destination]()
    @Published var selectedDestination: Destination? {
        didSet { addToRecentSection(selectedDestination) }
    }
    @Published var error: String?
    
    private var service: DestinationFetchingService
    
    init(service: DestinationFetchingService) {
        self.service = service
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
