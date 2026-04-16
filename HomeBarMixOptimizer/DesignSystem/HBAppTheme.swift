
import SwiftUI

struct HBAppTheme: Equatable {
    var variant: AccentVariant

    var accent: Color {
        switch variant {
        case .lime: return HBColor.limeZest
        case .mint: return HBColor.mintMist
        case .arctic: return HBColor.arcticFizz
        }
    }

    var heroGradient: LinearGradient {
        LinearGradient(
            colors: [
                HBColor.structure.opacity(0.95),
                accent.opacity(0.72),
                HBColor.mintMist.opacity(0.42),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var hintGradient: LinearGradient {
        LinearGradient(
            colors: [HBColor.berryPop.opacity(0.88), accent.opacity(0.62)],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    var primaryButtonGradient: LinearGradient {
        LinearGradient(
            colors: [HBColor.success, accent.opacity(0.88)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private enum HBAppThemeKey: EnvironmentKey {
    static var defaultValue: HBAppTheme { HBAppTheme(variant: .lime) }
}

extension EnvironmentValues {
    var hbAppTheme: HBAppTheme {
        get { self[HBAppThemeKey.self] }
        set { self[HBAppThemeKey.self] = newValue }
    }
}
