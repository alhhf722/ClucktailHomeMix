
import SwiftUI

struct HBTasteBalanceStrip: View {
    let balance: TasteBalance

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Taste balance")
                .font(.headline)
                .foregroundStyle(HBColor.structure)

            VStack(spacing: 10) {
                row("Sweetness", balance.sweetness, HBColor.berryPop)
                row("Acidity", balance.acidity, HBColor.limeZest)
                row("Bitterness", balance.bitterness, HBColor.structure.opacity(0.55))
                row("Fizz", balance.fizz, HBColor.arcticFizz)
                row("Aroma", balance.aroma, HBColor.mintMist)
            }
        }
    }

    private func row(_ title: String, _ value: Double, _ tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(HBColor.secondary)
                Spacer()
                Text("\(Int((value * 100).rounded()))%")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(HBColor.structure.opacity(0.75))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white)
                        .overlay {
                            Capsule().strokeBorder(HBColor.structure.opacity(0.12), lineWidth: 1)
                        }

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [tint.opacity(0.25), tint],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(10, geo.size.width * value))
                }
            }
            .frame(height: 12)
        }
    }
}

#Preview {
    HBTasteBalanceStrip(balance: .neutral)
        .padding()
        .background(HBColor.canvas)
}
