
import SwiftUI

struct RecipesView: View {
    @EnvironmentObject private var store: AppDataStore
    @State private var recipeQuery = ""

    private var sortedRecipes: [Recipe] {
        store.recipes.sorted(by: { $0.createdAt > $1.createdAt })
    }

    private var visibleRecipes: [Recipe] {
        let q = recipeQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if q.isEmpty { return sortedRecipes }
        return sortedRecipes.filter {
            $0.title.lowercased().contains(q) || $0.subtitle.lowercased().contains(q)
        }
    }

    var body: some View {
        Group {
            if store.recipes.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        HBHeroHeader(
                            title: "Recipes",
                            subtitle: "Save great blends from the mixer — reopen them in one tap.",
                            systemImage: "book.fill"
                        )

                        empty
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .scrollIndicators(.hidden)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(visibleRecipes) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                HStack(alignment: .center, spacing: 12) {
                                    RecipeRow(recipe: recipe)
                                    Image(systemName: "chevron.right")
                                        .font(.caption.weight(.bold))
                                        .foregroundStyle(HBColor.secondary.opacity(0.65))
                                }
                                .hbGlassCell()
                            }
                            .buttonStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contextMenu {
                                Button(role: .destructive) {
                                    store.deleteRecipe(id: recipe.id)
                                } label: {
                                    Label("Delete recipe", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
                .scrollIndicators(.hidden)
                .searchable(text: $recipeQuery, prompt: "Search recipes…")
            }
        }
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Recipes")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var empty: some View {
        HBGlassCard(gradient: HBGradient.berryFizz) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Nothing here yet — totally fine ✨")
                    .font(.headline)
                    .foregroundStyle(Color.white)

                Text("Build a mix in the Mixer, then tap Save as recipe.")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)

                HBPrimaryPillButton(title: "Open mixer", systemImage: "sparkles") {
                    store.selectedTab = 1
                }
            }
        }
    }
}

private struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(HBGradient.liquidBlend(from: HBColor.limeZest, to: HBColor.arcticFizz))
                .frame(width: 54, height: 54)
                .overlay {
                    Text("🍹")
                        .font(.title2)
                }

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Text(recipe.title)
                        .font(.headline)
                        .foregroundStyle(HBColor.structure)
                        .multilineTextAlignment(.leading)
                    if recipe.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundStyle(HBColor.citrusGlow)
                            .font(.subheadline.weight(.bold))
                    }
                }

                Text(recipe.subtitle)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(HBColor.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    NavigationStack {
        RecipesView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
