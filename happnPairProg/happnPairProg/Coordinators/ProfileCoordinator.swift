//
//  ProfileCoordinator.swift
//  happnPairProg
//
//  Created by Bin CHEN on 13/01/2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    let source: UINavigationController
    let user: User
    init(source: UINavigationController, user: User) {
        self.source = source
        self.user = user
    }
    
    override func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        // set user for vc
        source.pushViewController(vc, animated: true)
    }
}
