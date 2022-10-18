//
//  RootViewController.swift
//  Fima
//
//  Created by Nam Nguyễn on 12/10/2022.
//  Copyright © 2022 Fima. All rights reserved.
//

//import Anchorage
import RIBs
import RxSwift
import UIKit
import Main

///@mockable
protocol RootPresentableListener: AnyObject {
    
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    private var currentViewController: ViewControllable?
    
    private var current: UIViewController
    
    init() {
        self.current = MainViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews() {
        add(asChildViewController: current, to: self.view)
    }

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    // MARK: - RootViewControllable
    
    func replaceScreen(viewController: ViewControllable) {
        viewController.uiviewController.willMove(toParent: self)
        addChild(viewController.uiviewController)
        view.addSubview(viewController.uiviewController.view)
        currentViewController?.uiviewController.willMove(toParent: nil)
        currentViewController?.uiviewController.view.removeFromSuperview()
        currentViewController?.uiviewController.removeFromParent()
        viewController.uiviewController.didMove(toParent: self)
        currentViewController = viewController
    }
}

extension UIViewController {
    public func add(asChildViewController viewController: UIViewController, to parentView: UIView) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        parentView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
}

