//
//  UInt64+Extensions.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation

public extension UInt64 {
    
    static func toNanoseconds(from seconds: Double) -> UInt64 {
        UInt64(seconds * 1000000000)
    }
    
    func toSeconds() -> Double {
        Double(self) / 1000000000
    }
}
