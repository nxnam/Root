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
    func attachHome() {
    }
    
    func attachFollowing() {
    }
    
    func attachPersonal() {
    }
    
    

    private let homeBuilder: HomeBuildable
    private var homeRouter: HomeRouting?
    private let followingBuilder: FollowingBuildable
    private var followingRouter: FollowingRouting?
    private let personalBuilder: PersonalBuildable
    private var personalRouter: PersonalRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        homeBuilder: HomeBuildable,
        followingBuilder: FollowingBuilder,
        personalBuilder: PersonalBuilder
    ) {
        self.homeBuilder = homeBuilder
        self.followingBuilder = followingBuilder
        self.personalBuilder = personalBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
