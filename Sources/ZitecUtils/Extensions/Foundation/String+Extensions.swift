//
//  String+Extensions.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation

public extension String {
    
    static let emptyString = ""
    
    var base64Encoded: String { Data(utf8).base64EncodedString() }
    
    /// Returns false if the current string is empty or contains only whitespaces / new lines.
    var notEmpty: Bool {
        guard !withoutWhitespaces.withoutNewlines.isEmpty else { return false }
        return true
    }
    
    /// Returns a new string without additional whitespaces. Keeps only one if more exist.
    var withoutWhitespaces: String {
        let components = self.components(separatedBy: .whitespaces)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    /// Returns a new string without additional whitespaces. Keeps none.
    var removingAllWhitespaces: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: "")
    }
    
    /// Returns a new string without additional new lines. Keeps only one if more exist.
    var withoutNewlines: String {
        let components = self.components(separatedBy: .newlines)
        return components.filter { !$0.isEmpty }.joined(separator: "\n")
    }
    
    init?<T>(_ value: T?) where T: LosslessStringConvertible {
        guard let value = value else { return nil }
        self.init(value)
    }
    
    /// Removes additional whitespaces from the current string. Keeps only one if more exist.
    mutating func condenseWhitespaces() {
        self = withoutWhitespaces
    }
    
    /// Removes additional new lines from the current string. Keeps only one if more exist.
    mutating func condenseNewlines() {
        self = withoutNewlines
    }
    
    /// Removes additional whitespaces / new lines from the current string. Keeps only one if more exist.
    mutating func condenseWhitespacesAndNewlines() {
        self = withoutWhitespaces.withoutNewlines
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        substring(from: range.lowerBound, to: range.upperBound)
    }
}
