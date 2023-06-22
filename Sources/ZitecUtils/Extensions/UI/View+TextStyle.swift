//
//  View+TextStyle.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import SwiftUI

public struct TextStyle {
    let font: Font
    let color: Color
}

public struct StyleText: ViewModifier {
    let textStyle: TextStyle

    public func body(content: Content) -> some View {
        content
            .font(textStyle.font)
            .foregroundColor(textStyle.color)
    }
}

public extension View {
    func styleText(with textStyle: TextStyle) -> some View {
        modifier(StyleText(textStyle: textStyle))
    }
}
