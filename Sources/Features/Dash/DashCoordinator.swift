//
//  DashCoordinator.swift
//  TCC
//
//  Created by Adriano Guimarães Soares on 05/01/19.
//  Copyright © 2019 Adriano Soares. All rights reserved.
//

import Foundation
import Firebase
import XCoordinator

enum DashRoute: Route {
    case dash(User)
}

class DashCoordinator: NavigationCoordinator<DashRoute> {

    private let user: User

    init(user: User) {
        self.user = user
        super.init(initialRoute: .dash(user))
    }

    override func prepareTransition(for route: DashRoute) -> NavigationTransition {
        switch route {
        case .dash(let user):
            let vm = DashViewModel(router: anyRouter, user: user)
            let vc = DashViewController(viewModel: vm)
            return .push(vc)
        }
    }
}
