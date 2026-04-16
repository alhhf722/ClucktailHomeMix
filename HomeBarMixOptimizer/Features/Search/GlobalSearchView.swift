
import SwiftUI

struct GlobalSearchView: View {
    @EnvironmentObject private var store: AppDataStore
    @State private var query = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                if trimmedQuery.isEmpty {
                    HBPlaceholderBlock(
                        systemImage: "magnifyingglass",
                        title: "Search",
                        message: "Type an ingredient, recipe, or playlist name."
                    )
                    .hbGlassCell()
                } else {
                    if !ingredientHits.isEmpty {
                        sectionHeader("Ingredients")
                        VStack(spacing: 10) {
                            ForEach(ingredientHits) { ing in
                                NavigationLink {
                                    IngredientDetailView(ingredient: ing)
                                } label: {
                                    HStack(alignment: .center, spacing: 12) {
                                        Text(ing.category.emoji)
                                            .font(.title2)
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(ing.name)
                                                .font(.headline)
                                                .foregroundStyle(HBColor.structure)
                                            Text(ing.category.title)
                                                .font(.caption.weight(.semibold))
                                                .foregroundStyle(HBColor.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer(minLength: 0)
                                        Image(systemName: "chevron.right")
                                            .font(.caption.weight(.bold))
                                            .foregroundStyle(HBColor.secondary.opacity(0.65))
                                    }
                                    .hbGlassCell()
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !recipeHits.isEmpty {
                        sectionHeader("Recipes")
                        VStack(spacing: 10) {
                            ForEach(recipeHits) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe)
                                } label: {
                                    HStack(alignment: .center, spacing: 12) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(recipe.title)
                                                .font(.headline)
                                                .foregroundStyle(HBColor.structure)
                                            Text(recipe.subtitle)
                                                .font(.caption.weight(.semibold))
                                                .foregroundStyle(HBColor.secondary)
                                                .lineLimit(2)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer(minLength: 0)
                                        Image(systemName: "chevron.right")
                                            .font(.caption.weight(.bold))
                                            .foregroundStyle(HBColor.secondary.opacity(0.65))
                                    }
                                    .hbGlassCell()
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !playlistHits.isEmpty {
                        sectionHeader("Playlists")
                        VStack(spacing: 10) {
                            ForEach(playlistHits) { playlist in
                                NavigationLink {
                                    PlaylistDetailView(playlist: playlist)
                                } label: {
                                    HStack(alignment: .center, spacing: 12) {
                                        Text(playlist.emoji)
                                            .font(.system(size: 36))
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(playlist.title)
                                                .font(.headline)
                                                .foregroundStyle(HBColor.structure)
                                            Text(playlist.description)
                                                .font(.caption.weight(.semibold))
                                                .foregroundStyle(HBColor.secondary)
                                                .lineLimit(2)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer(minLength: 0)
                                        Image(systemName: "chevron.right")
                                            .font(.caption.weight(.bold))
                                            .foregroundStyle(HBColor.secondary.opacity(0.65))
                                    }
                                    .hbGlassCell()
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !hasAnyHit {
                        HBPlaceholderBlock(
                            systemImage: "questionmark.circle",
                            title: "No results",
                            message: "Try another word or a shorter query."
                        )
                        .hbGlassCell()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $query, prompt: "Ingredients, recipes, playlists…")
        .toolbar(.hidden, for: .tabBar)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title3.weight(.bold))
            .foregroundStyle(HBColor.structure)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var ingredientHits: [Ingredient] {
        store.searchIngredients(query: trimmedQuery)
    }

    private var recipeHits: [Recipe] {
        store.searchRecipes(query: trimmedQuery)
    }

    private var playlistHits: [DiscoveryPlaylist] {
        store.searchPlaylists(query: trimmedQuery)
    }

    private var hasAnyHit: Bool {
        !ingredientHits.isEmpty || !recipeHits.isEmpty || !playlistHits.isEmpty
    }
}

#Preview {
    NavigationStack {
        GlobalSearchView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
