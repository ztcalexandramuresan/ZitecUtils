//
//  File.swift
//  
//
//  Created by alexandra.muresan on 22.06.2023.
//

import UIKit

class NavigationFlowCoordinator: NSObject, FlowCoordinator {
    
    fileprivate (set) var parentFlow: FlowCoordinator?
    fileprivate (set) var flowPresentation: FlowCoordinatorPresentation
    
    private (set) var navigationController: UINavigationController?
    
    var mainViewController: UIViewController? {
        navigationController
    }
    
    // MARK: - Lifecycle
    
    required init(parent: FlowCoordinator? = nil, presentation: FlowCoordinatorPresentation = .custom) {
        parentFlow = parent
        flowPresentation = presentation
    }
    
    func initMainViewController() {
        guard navigationController == nil else { return }
        
        // Starting flow from an existing flow
        if let parentFlow = parentFlow {
            if flowPresentation == .push {
                if let parentNavFlow = parentFlow as? NavigationFlowCoordinator {
                    navigationController = parentNavFlow.navigationController
                }
            } else {
                let root = firstScreen()
                navigationController = UINavigationController(rootViewController: root)
            }
            // Starting flow with no parent
        } else {
            if flowPresentation == .custom {
                let root = firstScreen()
                navigationController = UINavigationController(rootViewController: root)
            }
        }
    }
    
    func firstScreen() -> UIViewController { UIViewController() }

    func finish(customDismiss: CustomPresentation?, completion: (() -> Void)? = nil) {
        if let customDismiss = customDismiss {
            guard let mainViewController = mainViewController else {
                assertionFailure("No main view controller")
                return
            }
            customDismiss(mainViewController)
            completion?()
        } else {
            if flowPresentation == .present {
                guard let parentFlow = parentFlow else {
                    assertionFailure("Parent nil when trying to dismiss")
                    return
                }
                parentFlow.mainViewController?.dismiss(animated: true, completion: completion)
            }
        }
        navigationController = nil
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension NavigationFlowCoordinator {
    
    var navController: UINavigationController? {
        navigationController?.presentedViewController as? UINavigationController ?? navigationController
    }
}
