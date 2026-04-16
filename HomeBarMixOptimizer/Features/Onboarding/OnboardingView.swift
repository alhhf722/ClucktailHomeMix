
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: AppDataStore

    @State private var page = 0
    @State private var selectedTemplates: Set<PantryTemplate> = []

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $page) {
                OnboardingPage(
                    emoji: "🍹",
                    title: "Your home flavor lab",
                    text: "We start with My bar — only what you actually keep at home."
                )
                .tag(0)

                OnboardingPage(
                    emoji: "✨",
                    title: "Mix like a pro",
                    text: "In the Mixer, drag capsules into the glass — color and hints follow the balance."
                )
                .tag(1)

                OnboardingPage(
                    emoji: "🧃",
                    title: "Ideas without endless scrolling",
                    text: "Playlists set the mood fast — recipes and the shopping list fill gaps without extra store runs."
                )
                .tag(2)

                OnboardingTemplatePickPage(selected: $selectedTemplates)
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            VStack(spacing: 12) {
                HBPrimaryPillButton(title: page < 3 ? "Next" : "Let's go", systemImage: page < 3 ? "arrow.right" : "checkmark") {
                    if page < 3 {
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                            page += 1
                        }
                    } else {
                        store.applyOnboardingSelections(selectedTemplates: selectedTemplates)
                        store.completeOnboarding()
                    }
                }

                Button("Close") {
                    store.applyOnboardingSelections(selectedTemplates: selectedTemplates)
                    store.completeOnboarding()
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(HBColor.secondary)
            }
            .padding(16)
            .background(HBColor.canvas)
        }
        .background(HBColor.canvas.ignoresSafeArea())
    }
}

private struct OnboardingPage: View {
    let emoji: String
    let title: String
    let text: String

    var body: some View {
        VStack(spacing: 18) {
            HBGlassCard(gradient: HBGradient.berryFizz) {
                VStack(spacing: 12) {
                    Text(emoji)
                        .font(.system(size: 64))

                    Text(title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)

                    Text(text)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.white.opacity(0.92))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .padding(.top, 24)
    }
}

private struct OnboardingTemplatePickPage: View {
    @Binding var selected: Set<PantryTemplate>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HBGlassCard(gradient: HBGradient.berryFizz) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("🏠")
                            .font(.system(size: 52))

                        Text("What do you usually keep at home?")
                            .font(.title2.weight(.bold))
                            .foregroundStyle(Color.white)

                        Text("Pick one or more templates — we’ll add typical ingredients to your bar (no duplicate names).")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.white.opacity(0.92))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                VStack(spacing: 10) {
                    ForEach(PantryTemplate.allCases) { tpl in
                        let isOn = selected.contains(tpl)
                        Button {
                            if isOn {
                                selected.remove(tpl)
                            } else {
                                selected.insert(tpl)
                            }
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(tpl.title)
                                        .font(.headline)
                                        .foregroundStyle(HBColor.structure)
                                    Text(tpl.items.map(\.0).joined(separator: ", "))
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(HBColor.secondary)
                                        .lineLimit(2)
                                }
                                Spacer()
                                Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundStyle(isOn ? HBColor.success : HBColor.secondary)
                            }
                            .padding(14)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.white)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .strokeBorder(
                                                isOn ? HBColor.success.opacity(0.55) : HBColor.structure.opacity(0.12),
                                                lineWidth: isOn ? 2 : 1
                                            )
                                    }
                            }
                            .hbCardShadow()
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppDataStore())
        .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
}
