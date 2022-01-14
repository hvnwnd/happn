//
//  UserListCoordinator.swift
//  happnPairProg
//
//  Created by Bin CHEN on 13/01/2022.
//

import Foundation
import UIKit

class UserListCoordinator: Coordinator {
    let source: UINavigationController?
    
    init(source: UINavigationController?) {
        self.source = source
    }
    
    override func start() {
        
    }
    
    func showProfile(user: User) {
        guard let source = source else { return }
        let profileCoordinator = ProfileCoordinator(source: source, user: user)
        coordinate(coordinator: profileCoordinator)
    }
}
