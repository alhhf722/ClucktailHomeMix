
import SwiftUI

struct HBPrimaryPillButton: View {
    @Environment(\.hbAppTheme) private var theme

    let title: String
    let systemImage: String?
    let action: () -> Void

    init(title: String, systemImage: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.headline.weight(.bold))
                }
                Text(title)
                    .font(.headline.weight(.bold))
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(theme.primaryButtonGradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.35), lineWidth: 1)
                    }
            }
            .hbGlowShadow()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HBPrimaryPillButton(title: "Mix", systemImage: "wand.and.stars") {}
        .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
        .padding()
        .background(HBColor.canvas)
}
