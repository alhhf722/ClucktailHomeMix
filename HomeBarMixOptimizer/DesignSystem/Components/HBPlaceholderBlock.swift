
import SwiftUI

struct HBPlaceholderBlock: View {
    let systemImage: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 40, weight: .semibold))
                .foregroundStyle(HBColor.secondary)

            Text(title)
                .font(.headline)
                .foregroundStyle(HBColor.structure)
                .multilineTextAlignment(.center)

            Text(message)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(HBColor.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 16)
    }
}
