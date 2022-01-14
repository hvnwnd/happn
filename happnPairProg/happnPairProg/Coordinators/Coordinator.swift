//
//  Coordinator.swift
//  happnPairProg
//
//  Created by Bin CHEN on 13/01/2022.
//

import Foundation

class Coordinator {
    private let identifier = UUID()
    
    var childrenCoordinators: [UUID: Any] = [:]
    
    private func store(coordinator: Coordinator) {
        childrenCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free(coordinator: Coordinator) {
        childrenCoordinators[coordinator.identifier] = nil
    }
    
    func start() {
        fatalError()
    }
    
    func coordinate(coordinator: Coordinator) {
        store(coordinator: coordinator)
        coordinator.start()
    }
}
