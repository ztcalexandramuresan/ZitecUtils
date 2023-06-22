//
//  FlowCoordinator.swift
//  
//
//  Created by alexandra.muresan on 22.06.2023.
//

import Foundation
import UIKit

public enum FlowCoordinatorPresentation {
    case present, push, custom
}

public typealias CustomPresentation = ((_ mainViewController: UIViewController) -> Void)

public protocol FlowCoordinator: AnyObject {
    
    var mainViewController: UIViewController? { get }
    var flowPresentation: FlowCoordinatorPresentation { get }
    var parentFlow: FlowCoordinator? { get }
    
    init(parent: FlowCoordinator?, presentation: FlowCoordinatorPresentation)

    func initMainViewController()
    func firstScreen() -> UIViewController
    
    func start(customPresentation: CustomPresentation?)
    func finish(customDismiss: CustomPresentation?, completion: (() -> Void)?)
}

// MARK: - Default implementation

public extension FlowCoordinator {
    
    func start(customPresentation: CustomPresentation? = nil) {
        initMainViewController()
        self.start(flowPresentation: flowPresentation, customPresentation: customPresentation)
    }
    
    func finish(customDismiss: CustomPresentation?, completion: (() -> Void)? = nil) {
        self.finish(flowPresentation: flowPresentation, customDismiss: customDismiss, completion: completion)
    }
}

// MARK: - Starting a flow

extension FlowCoordinator {
    
    fileprivate func start(flowPresentation: FlowCoordinatorPresentation,
                           customPresentation: CustomPresentation? = nil) {
        
        guard let mainViewController = mainViewController else {
            assertionFailure("Mo main view controller")
            return
        }
        
        switch flowPresentation {
        case .push:
            startPushed()
        case .present:
            startPresented(mainViewController)
        case .custom:
            if let custom = customPresentation {
                custom(mainViewController)
            }
        }
    }
    
    fileprivate func startPresented(_ controller: UIViewController) {
        guard let parentFlow = parentFlow else {
            assertionFailure("Flow needs to have a parent in order to be presented")
            return
        }
        parentFlow.mainViewController?.present(controller, animated: true, completion: nil)
    }
    
    fileprivate func startPushed() {
        guard let parentNavController = parentFlow?.mainViewController as? UINavigationController else {
            assertionFailure("Main view controller must be a UINavigationController")
            return
        }
        let firstScreen = firstScreen()
        parentNavController.pushViewController(firstScreen, animated: true)
    }
}

// MARK: - Finishing a flow

extension FlowCoordinator {
    
    fileprivate func finish(flowPresentation: FlowCoordinatorPresentation,
                            customDismiss: CustomPresentation? = nil,
                            completion: (() -> Void)? = nil) {
        
        switch flowPresentation {
        case .push:
            finishPushed()
        case .present:
            finishPresented(completion: completion)
        case .custom:
            if let custom = customDismiss, let mainViewController = mainViewController {
                custom(mainViewController)
            }
        }
    }
    
    fileprivate func finishPresented(completion: (() -> Void)? = nil) {
        guard let parentFlow = parentFlow else {
            assertionFailure("Parent nil when trying to dismiss")
            return
        }
        parentFlow.mainViewController?.dismiss(animated: true, completion: completion)
    }
    
    fileprivate func finishPushed() {
        guard let parentNavController = parentFlow?.mainViewController as? UINavigationController else {
            assertionFailure("Parent must be UINavigationController to pop")
            return
        }
        parentNavController.popViewController(animated: true)
    }
}
