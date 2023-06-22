//
//  Bundle+Extensions.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation

public extension Bundle {

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
