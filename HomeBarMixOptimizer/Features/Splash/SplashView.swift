import SwiftUI

struct SplashView: View {
    @State private var breath = false

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 45)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate

            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height
                let m = min(w, h)

                ZStack {
                    baseFill
                        .scaleEffect(breath ? 1.03 : 0.98)

                    AngularGradient(
                        gradient: Gradient(colors: [
                            HBColor.limeZest.opacity(0),
                            HBColor.mintMist.opacity(0.42),
                            HBColor.arcticFizz.opacity(0.32),
                            HBColor.berryPop.opacity(0.28),
                            HBColor.limeZest.opacity(0),
                        ]),
                        center: .center,
                        angle: .degrees(t * 38)
                    )
                    .blur(radius: 72)
                    .scaleEffect(1.45)
                    .opacity(breath ? 0.88 : 0.52)
                    .blendMode(.plusLighter)

                    ambientBlobs(width: w, height: h, t: t)

                    sparkles(in: geo.size, t: t)

                    centerMark(minSide: m, t: t)
                }
                .frame(width: w, height: h)
            }
        }
        .background(Color(hex: 0x14182A))
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 2.6).repeatForever(autoreverses: true)) {
                breath = true
            }
        }
    }

    private var baseFill: some View {
        LinearGradient(
            colors: [
                Color(hex: 0x171B2E),
                HBColor.structure,
                Color(hex: 0x252A44),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private func ambientBlobs(width w: CGFloat, height h: CGFloat, t: Double) -> some View {
        ZStack {
            softBlob(HBColor.limeZest, cx: w * 0.22, cy: h * 0.28, t: t, k: 1.1, r: 130)
            softBlob(HBColor.berryPop, cx: w * 0.8, cy: h * 0.7, t: t, k: 0.85, r: 150)
            softBlob(HBColor.mintMist, cx: w * 0.72, cy: h * 0.24, t: t, k: 1.35, r: 110)
            softBlob(HBColor.arcticFizz, cx: w * 0.18, cy: h * 0.76, t: t, k: 0.95, r: 125)
        }
        .allowsHitTesting(false)
    }

    private func softBlob(_ color: Color, cx: CGFloat, cy: CGFloat, t: Double, k: Double, r: CGFloat) -> some View {
        let ox = sin(t * k + 0.7) * 22
        let oy = cos(t * (k * 1.1) + 0.3) * 18
        return Circle()
            .fill(
                RadialGradient(
                    colors: [color.opacity(0.5), color.opacity(0)],
                    center: .center,
                    startRadius: 0,
                    endRadius: r
                )
            )
            .frame(width: r * 2, height: r * 2)
            .position(x: cx + ox, y: cy + oy)
            .blur(radius: 32)
    }

    private func sparkles(in size: CGSize, t: Double) -> some View {
        Canvas { context, canvasSize in
            let count = 18
            for i in 0..<count {
                let seed = Double(i) * 1.618
                let x = canvasSize.width * (0.08 + CGFloat((sin(seed) * 0.5 + 0.5) * 0.84))
                let y = canvasSize.height * (0.1 + CGFloat((cos(seed * 1.3) * 0.5 + 0.5) * 0.8))
                let twinkle = 0.35 + 0.65 * pow(0.5 + 0.5 * sin(t * 2.4 + seed * 2), 2)
                let dot = CGRect(x: x, y: y, width: 3, height: 3)
                context.fill(
                    Path(ellipseIn: dot),
                    with: .color(Color.white.opacity(0.15 * twinkle))
                )
            }
        }
        .allowsHitTesting(false)
        .drawingGroup(opaque: false)
    }

    private func centerMark(minSide m: CGFloat, t: Double) -> some View {
        let pulse = 0.94 + sin(t * 2.8) * 0.045
        return ZStack {
            ForEach(0..<3, id: \.self) { ring in
                let idx = CGFloat(ring)
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                HBColor.mintMist.opacity(0.55),
                                HBColor.limeZest.opacity(0.4),
                                HBColor.arcticFizz.opacity(0.35),
                                HBColor.berryPop.opacity(0.3),
                                HBColor.mintMist.opacity(0.55),
                            ]),
                            center: .center,
                            angle: .degrees(t * (18 + Double(ring) * 8))
                        ),
                        lineWidth: 1.5
                    )
                    .frame(width: m * (0.4 + idx * 0.1), height: m * (0.4 + idx * 0.1))
                    .rotationEffect(.degrees(t * (10 + Double(ring) * 5)))
                    .opacity(0.75 - Double(ring) * 0.18)
            }

            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: m * 0.33, height: m * 0.33)
                .overlay {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.55),
                                    Color.white.opacity(0.12),
                                    Color.white.opacity(0.4),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.2
                        )
                }
                .shadow(color: HBColor.limeZest.opacity(0.32), radius: 22, y: 10)
                .scaleEffect(pulse)

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [HBColor.citrusGlow.opacity(0.95), HBColor.limeZest.opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: m * 0.07, height: m * 0.14)
                .blur(radius: 1)
                .offset(y: sin(t * 3.6) * 5)
                .shadow(color: HBColor.citrusGlow.opacity(0.45), radius: 12)

            Circle()
                .fill(HBColor.mintMist.opacity(0.25))
                .frame(width: m * 0.08, height: m * 0.08)
                .offset(x: m * 0.09, y: -m * 0.07)
                .blur(radius: 6)
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    SplashView()
}
