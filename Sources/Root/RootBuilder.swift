//
//  RootBuilder.swift
//  Fima
//
//  Created by Nam Nguyễn on 12/10/2022.
//  Copyright © 2022 Fima. All rights reserved.
//

import RIBs
import Home
import Following
import Personal

///@mockable
protocol RootDependency: HomeDependency, FollowingDependency, PersonalDependency {
    // var webService: WebServicing { get }
}

final class RootComponent: Component<RootDependency> {

    private let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

///@mockable
protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        let homeBuilder = HomeBuilder(dependency: component.dependency)
        let followingBuilder = FollowingBuilder(dependency: component.dependency)
        let personalBuilder = PersonalBuilder(dependency: component.dependency)
        
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            homeBuilder: homeBuilder,
            followingBuilder: followingBuilder,
            personalBuilder: personalBuilder
        )
    }
}
