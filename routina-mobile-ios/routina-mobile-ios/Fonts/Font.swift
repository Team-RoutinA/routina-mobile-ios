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
    
    static var PretendardBold72: Font {
        return .pretend(type: .bold, size: 72)
    }
    
    static var PretendardExtraBold40: Font {
        return .pretend(type: .extraBold, size: 40)
    }
    
    static var PretendardBold40: Font {
        return .pretend(type: .bold, size: 40)
    }
    
    static var PretendardMedium40: Font {
        return .pretend(type: .medium, size: 40)
    }

    static var PretendardMedium20: Font {
        return .pretend(type: .medium, size: 20)
    }

    static var PretendardMedium14: Font {
        return .pretend(type: .medium, size: 14)
    }
    
    static var PretendardBold36: Font {
        return .pretend(type: .bold, size: 36)
    }
}
