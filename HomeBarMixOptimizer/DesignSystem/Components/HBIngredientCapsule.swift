
import SwiftUI

struct HBIngredientCapsule: View {
    let name: String
    let accent: Color
    let emoji: String
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: 10) {
            Text(emoji)
                .font(.title3)

            Text(name)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(HBColor.structure)
                .lineLimit(1)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            Capsule(style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [accent.opacity(0.55), Color.white.opacity(0.92)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    Capsule(style: .continuous)
                        .strokeBorder(Color.white.opacity(0.55), lineWidth: 1)
                }
        }
        .overlay {
            if isSelected {
                Capsule(style: .continuous)
                    .strokeBorder(HBColor.success, lineWidth: 3)
            }
        }
        .hbCardShadow()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack(spacing: 12) {
        HBIngredientCapsule(name: "Grapefruit juice", accent: HBColor.citrusGlow, emoji: "🍊")
        HBIngredientCapsule(name: "Mint syrup", accent: HBColor.mintMist, emoji: "🌿", isSelected: true)
    }
    .padding()
    .background(HBColor.canvas)
}
