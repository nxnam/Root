//
//  RootRouter.swift
//  Fima
//
//  Created by Nam Nguyễn on 12/10/2022.
//  Copyright © 2022 Fima. All rights reserved.
//

import RIBs
import Main

///@mockable
protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

///@mockable
protocol RootViewControllable: ViewControllable {
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    func attachMain() {
    }
    
    private let mainBuilder: MainBuildable
    private var mainRouter: MainRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuilder: MainBuildable
    ) {
        self.mainBuilder = mainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
