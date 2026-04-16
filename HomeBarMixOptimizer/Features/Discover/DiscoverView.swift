
import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject private var store: AppDataStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HBHeroHeader(
                    title: "Ideas",
                    subtitle: "Playlists for your pantry: pick a mood and build a mix without an hour of recipe hunting.",
                    systemImage: "lightbulb.max.fill"
                )

                HBGlassCard(gradient: HBGradient.citrusSplash) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Built from your bar")
                            .font(.headline)
                            .foregroundStyle(HBColor.structure)

                        Text("Open the Mixer with favorites — that’s where great combos often start.")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(HBColor.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Playlists")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(HBColor.structure)

                    ForEach(store.playlists) { playlist in
                        NavigationLink {
                            PlaylistDetailView(playlist: playlist)
                        } label: {
                            HBGlassCard(gradient: HBGradient.berryFizz) {
                                HStack(alignment: .top, spacing: 12) {
                                    Text(playlist.emoji)
                                        .font(.system(size: 40))

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(playlist.title)
                                            .font(.headline)
                                            .foregroundStyle(Color.white)

                                        Text(playlist.description)
                                            .font(.subheadline.weight(.medium))
                                            .foregroundStyle(Color.white.opacity(0.92))
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer(minLength: 0)
                                    Image(systemName: "chevron.right")
                                        .font(.headline.weight(.bold))
                                        .foregroundStyle(Color.white.opacity(0.85))
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Ideas")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DiscoverView()
            .environmentObject(AppDataStore())
    }
}
