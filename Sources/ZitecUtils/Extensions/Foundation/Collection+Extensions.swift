//
//  Collection+Extensions.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation

public extension Collection {

    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    
    init(repeating: [Element], count: Int) {
        self.init([[Element]](repeating: repeating, count: count).flatMap { $0 })
    }
    
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func repeated(count: Int) -> [Element] {
        [Element](repeating: self, count: count)
    }
}
