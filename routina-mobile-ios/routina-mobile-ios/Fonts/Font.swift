//
//  Font.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/25/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case black
        case bold
        case extraBold
        case extraLight
        case light
        case medium
        case regular
        case semibold
        case thin

        var value: String {
            switch self {
            case .black:
                return "Pretendard-Black"
            case .bold:
                return "Pretendard-Bold"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .light:
                return "Pretendard-Light"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .semibold:
                return "Pretendard-SemiBold"
            case .thin:
                return "Pretendard-Thin"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var PretendardBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
}
