
import SwiftUI

struct PlaylistDetailView: View {
    @EnvironmentObject private var store: AppDataStore

    let playlist: DiscoveryPlaylist

    private var missingNames: [String] {
        SubstitutionEngine.missingFromPlaylist(playlist, pantry: store.ingredients)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HBGlassCard(gradient: HBGradient.liquidBlend(from: HBColor.mintMist, to: HBColor.arcticFizz)) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(playlist.emoji)
                            .font(.system(size: 52))

                        Text(playlist.title)
                            .font(.title2.weight(.bold))
                            .foregroundStyle(Color.white)

                        Text(playlist.description)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.white.opacity(0.92))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                if !missingNames.isEmpty {
                    HBGlassCard(gradient: HBGradient.citrusSplash) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Missing for this idea")
                                .font(.headline)
                                .foregroundStyle(HBColor.structure)

                            Text("Add to your shopping list — or swap with something similar from your bar (see hints below).")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(HBColor.secondary)
                                .fixedSize(horizontal: false, vertical: true)

                            HBPrimaryPillButton(title: "Add missing to list", systemImage: "cart.badge.plus") {
                                store.addMissingPlaylistToShopping(playlist)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Build the base")
                        .font(.headline)
                        .foregroundStyle(HBColor.structure)

                    Text("Green checkmark means it’s already in My bar.")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(HBColor.secondary)

                    SuggestedIngredientRows(names: playlist.suggestedIngredientNames)
                }

                HBPrimaryPillButton(title: "Open mixer", systemImage: "sparkles") {
                    store.selectedTab = 1
                }
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Playlist")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

private struct SuggestedIngredientRows: View {
    @EnvironmentObject private var store: AppDataStore
    let names: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(names, id: \.self) { name in
                let has = SubstitutionEngine.pantryContains(suggestedName: name, pantry: store.ingredients)
                let swaps = has ? [] : SubstitutionEngine.swaps(forMissingName: name, pantry: store.ingredients, limit: 4)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(has ? "✅" : "🛒")
                        Text(name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(HBColor.structure)
                        Spacer()
                        if !has {
                            Button("Add to list") {
                                store.addShoppingItem(title: name, source: "Playlist")
                            }
                            .font(.caption.weight(.bold))
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background {
                        Capsule(style: .continuous)
                            .fill(Color.white)
                            .overlay {
                                Capsule(style: .continuous)
                                    .strokeBorder(HBColor.structure.opacity(0.12), lineWidth: 1)
                            }
                    }
                    .hbCardShadow()

                    if !has, !swaps.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Similar from your bar")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(HBColor.secondary)

                            ScrollView(.horizontal) {
                                HStack(spacing: 8) {
                                    ForEach(swaps) { ing in
                                        Button {
                                            store.addToMix(ingredientId: ing.id)
                                            store.selectedTab = 1
                                        } label: {
                                            HBIngredientCapsule(
                                                name: ing.name,
                                                accent: ing.category.accent,
                                                emoji: ing.category.emoji
                                            )
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        .padding(.leading, 4)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistDetailView(
            playlist: DiscoveryPlaylist(
                title: "Citrus charge",
                description: "Sample",
                emoji: "🍋",
                suggestedIngredientNames: ["Lime", "Tonic"]
            )
        )
        .environmentObject(AppDataStore())
        .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
