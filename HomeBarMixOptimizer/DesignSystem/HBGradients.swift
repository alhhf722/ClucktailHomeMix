
import SwiftUI

enum HBGradient {
    static let studioHero = LinearGradient(
        colors: [HBColor.structure.opacity(0.95), HBColor.arcticFizz.opacity(0.55), HBColor.mintMist.opacity(0.45)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let citrusSplash = LinearGradient(
        colors: [HBColor.citrusGlow, HBColor.limeZest.opacity(0.85)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let berryFizz = LinearGradient(
        colors: [HBColor.berryPop.opacity(0.9), HBColor.arcticFizz.opacity(0.65)],
        startPoint: .leading,
        endPoint: .trailing
    )

    static func liquidBlend(from: Color, to: Color) -> LinearGradient {
        LinearGradient(colors: [from, to], startPoint: .top, endPoint: .bottom)
    }

    static func glassSheen() -> LinearGradient {
        LinearGradient(
            colors: [Color.white.opacity(0.55), Color.white.opacity(0.08), Color.white.opacity(0.35)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
