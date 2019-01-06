//
//  HomeCoordinator.swift
//  TCC
//
//  Created by Adriano Guimarães Soares on 04/01/19.
//  Copyright © 2019 Adriano Soares. All rights reserved.
//

import Foundation
import XCoordinator
import Firebase

enum HomeRoute: Route {
    case dash
    case expenses
    //case config
}

class HomeCoordinator: TabBarCoordinator<HomeRoute> {

    let expensesRouter: AnyRouter<ChatRoute>
    let dashRouter: AnyRouter<DashRoute>

    init(user: User) {
        let expensesCoordinator: ChatCoordinator = .init(initialRoute: .expenses)
        expensesRouter = expensesCoordinator.anyRouter

        let dashCoordinator: DashCoordinator = .init(user: user)
        dashRouter = dashCoordinator.anyRouter

        super.init(tabs: [dashRouter, expensesRouter],
                   select: 0)
    }

    override func prepareTransition(for route: HomeRoute) -> TabBarTransition {
        switch route {
        case .dash:
            return .select(index: 0)

        case .expenses:
            return .select(index: 1)

        //case .config:
        //    return .select(UIViewController())

        }
    }
}
