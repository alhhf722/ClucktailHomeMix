
import SwiftUI

struct HBGlassCard<Content: View>: View {
    let gradient: LinearGradient
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(gradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.45), lineWidth: 1)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(HBGradient.glassSheen().opacity(0.35))
                            .blendMode(.screen)
                    }
            }
            .hbCardShadow()
    }
}

#Preview {
    HBGlassCard(gradient: HBGradient.berryFizz) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tropical vibe")
                .font(.headline)
                .foregroundStyle(Color.white)
            Text("3 ingredients • fizz • citrus")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.9))
        }
    }
    .padding()
    .background(HBColor.canvas)
}
