
import SwiftUI

enum HBShadow {
    static let cardLift = (color: HBColor.structure.opacity(0.18), radius: CGFloat(18), y: CGFloat(10))
    static let softGlow = (color: HBColor.success.opacity(0.35), radius: CGFloat(22), y: CGFloat(8))
}

extension View {
    func hbCardShadow() -> some View {
        shadow(color: HBShadow.cardLift.color, radius: HBShadow.cardLift.radius, x: 0, y: HBShadow.cardLift.y)
    }

    func hbGlowShadow() -> some View {
        shadow(color: HBShadow.softGlow.color, radius: HBShadow.softGlow.radius, x: 0, y: HBShadow.softGlow.y)
    }

    func hbGlassCell() -> some View {
        padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .strokeBorder(HBColor.structure.opacity(0.14), lineWidth: 1)
                    }
            }
            .hbCardShadow()
    }
}
