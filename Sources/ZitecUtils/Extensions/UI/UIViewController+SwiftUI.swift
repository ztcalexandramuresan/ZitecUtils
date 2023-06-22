//
//  UIViewController+SwiftUI.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import UIKit
import SwiftUI

public extension UIViewController {
    
    /// Adds a SwiftUI view as a child view controller handled by UIKit.
    func container<Content: View>(with swiftUI: Content) -> UIView {
        let hosting = UIHostingController(rootView: swiftUI)

        /// Add as a child of the current view controller.
        addChild(hosting)

        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        
        let container = UIView()
        container.addSubview(hosting.view)
        
        let constraints = [
            hosting.view.topAnchor.constraint(equalTo: container.topAnchor),
            hosting.view.leftAnchor.constraint(equalTo: container.leftAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            hosting.view.rightAnchor.constraint(equalTo: container.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

        /// Notify the hosting controller that it has
        /// been moved to the current view controller.
        hosting.didMove(toParent: self)
        
        return container
    }
}

public extension UIView {
    
    static func container<Content: View>(with swiftUI: Content) -> UIView {
        let hosting = UIHostingController(rootView: swiftUI)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        
        let container = UIView()
        container.addSubview(hosting.view)
        
        let constraints = [
            hosting.view.topAnchor.constraint(equalTo: container.topAnchor),
            hosting.view.leftAnchor.constraint(equalTo: container.leftAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            hosting.view.rightAnchor.constraint(equalTo: container.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return container
    }
}

