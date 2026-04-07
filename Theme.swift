import SwiftUI

extension Color {
    static let appBackground = Color.white
    static let appPrimary = Color.black
    static let appSecondary = Color.gray
    static let appBorder = Color.black
    static let appLightGray = Color.gray.opacity(0.1)
}

extension Font {
    static func appTitle() -> Font {
        return .system(size: 28, weight: .bold)
    }
    
    static func appHeadline() -> Font {
        return .system(size: 20, weight: .semibold)
    }
    
    static func appBody() -> Font {
        return .system(size: 16, weight: .regular)
    }
    
    static func appCaption() -> Font {
        return .system(size: 14, weight: .regular)
    }
    
    static func appSmall() -> Font {
        return .system(size: 12, weight: .regular)
    }
}

struct MinimalistButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
