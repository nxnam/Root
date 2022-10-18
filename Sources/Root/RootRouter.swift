//
//  RootRouter.swift
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
protocol RootInteractable: Interactable, HomeListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

///@mockable
protocol RootViewControllable: ViewControllable {
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let homeBuilder: HomeBuildable
    private var homeRouter: HomeRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        homeBuilder: HomeBuildable,
        followingBuilder: FollowingBuilder,
        personalBuilder: PersonalBuilder
    ) {
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
