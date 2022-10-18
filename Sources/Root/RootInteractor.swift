//
//  RootInteractor.swift
//  Fima
//
//  Created by Nam Nguyễn on 12/10/2022.
//  Copyright © 2022 Fima. All rights reserved.
//

import RIBs
import RxSwift

///@mockable
protocol RootRouting: ViewableRouting {
    func attachHome()
}

///@mockable
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

///@mockable
protocol RootListener: AnyObject {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.attachHome()
    }
}
