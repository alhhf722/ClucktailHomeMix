
import SwiftUI

enum HBColor {
    static let canvas = Color(hex: 0xFFFFFF)
    static let structure = Color(hex: 0x444A6B)
    static let secondary = Color(hex: 0x74716F)
    static let success = Color(hex: 0x6AC66C)

    static let limeZest = Color(hex: 0xC4F25E)
    static let mintMist = Color(hex: 0x7FE3D2)
    static let arcticFizz = Color(hex: 0x6BC4FF)
    static let citrusGlow = Color(hex: 0xFFD36A)
    static let berryPop = Color(hex: 0xFF7BB0)
}

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }
}
