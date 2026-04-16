
import SwiftUI

struct HBHeroHeader: View {
    @Environment(\.hbAppTheme) private var theme

    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(theme.heroGradient)
                .overlay {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.35), lineWidth: 1)
                }
                .hbCardShadow()

            VStack(alignment: .leading, spacing: 10) {
                Label(title, systemImage: systemImage)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.white)
                    .labelStyle(.titleAndIcon)

                Text(subtitle)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HBHeroHeader(
        title: "Mixer",
        subtitle: "Blend, balance, and chase the perfect sip.",
        systemImage: "sparkles"
    )
    .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    .padding()
    .background(HBColor.canvas)
}
