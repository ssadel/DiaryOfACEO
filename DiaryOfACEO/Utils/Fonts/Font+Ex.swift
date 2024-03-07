//
//  Fonts.swift
//  Span
//
//  Created by Sidney Sadel on 8/3/23.
//

import SwiftUI

enum CustomFont: Equatable, Codable, CaseIterable {
    case reenieBeenie
    
    var name: String {
        switch self {
        case .reenieBeenie:
            return "ReenieBeanie"
        }
    }
}

extension Font {
    static func custom(_ customFont: CustomFont, size: CGFloat) -> Font {
        .custom(customFont.name, size: size)
    }
    
    static func custom(_ customFont: CustomFont, style: Font.TextStyle) -> Font {
        .custom(customFont.name, size: style.size, relativeTo: style)
    }
}

extension UIFont {
    static func custom(_ customFont: CustomFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: customFont.name, size: size) else {
            fatalError("\(customFont.name) font not found")
        }
        return font
    }
}

extension Font.TextStyle {
    private var style: UIFont.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        @unknown default:
            return .body
        }
    }
    
    var size: CGFloat {
        return UIFont.preferredFont(forTextStyle: self.style).pointSize
    }
}
