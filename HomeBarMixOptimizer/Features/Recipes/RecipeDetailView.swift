
import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject private var store: AppDataStore

    let recipe: Recipe

    private var current: Recipe {
        store.recipes.first { $0.id == recipe.id } ?? recipe
    }

    private var shareText: String {
        let lines = current.ingredientIds.map { current.displayName(for: $0, pantry: store.ingredients) }
        return RecipeShareText.build(recipe: current, ingredientLines: lines, steps: current.steps)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HBGlassCard(gradient: HBGradient.studioHero) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("🍹")
                                .font(.system(size: 44))
                            Spacer()
                            Button {
                                store.toggleFavorite(recipeId: current.id)
                            } label: {
                                Image(systemName: current.isFavorite ? "star.fill" : "star")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(Color.white.opacity(0.95))
                            }
                            .accessibilityLabel("Favorite")
                        }

                        Text(current.title)
                            .font(.title2.weight(.bold))
                            .foregroundStyle(Color.white)

                        Text(current.subtitle)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.white.opacity(0.92))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                if hasMissingIngredients {
                    HBGlassCard(gradient: HBGradient.citrusSplash) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Not everything is in your bar")
                                .font(.headline)
                                .foregroundStyle(HBColor.structure)

                            Text("Some items were removed or renamed — see what’s missing and what you can swap in.")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(HBColor.secondary)
                                .fixedSize(horizontal: false, vertical: true)

                            HBPrimaryPillButton(title: "Add missing to shopping list", systemImage: "cart.badge.plus") {
                                store.addMissingRecipeToShopping(current)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundStyle(HBColor.structure)

                    VStack(spacing: 10) {
                        ForEach(current.ingredientIds, id: \.self) { id in
                            ingredientBlock(for: id)
                        }
                    }
                }

                if !missingSubstitutionBlocks.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Swaps from what you have")
                            .font(.headline)
                            .foregroundStyle(HBColor.structure)

                        ForEach(Array(missingSubstitutionBlocks.enumerated()), id: \.offset) { _, block in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Instead of \(block.missingName)")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(HBColor.structure)

                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        ForEach(block.swaps) { ing in
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
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Steps")
                        .font(.headline)
                        .foregroundStyle(HBColor.structure)

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(current.steps.enumerated()), id: \.offset) { idx, step in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(idx + 1)")
                                    .font(.caption.weight(.black))
                                    .foregroundStyle(Color.white)
                                    .frame(width: 26, height: 26)
                                    .background {
                                        Circle().fill(HBColor.success)
                                    }

                                Text(step)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(HBColor.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .fill(Color.white)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                                            .strokeBorder(HBColor.structure.opacity(0.12), lineWidth: 1)
                                    }
                            }
                        }
                    }
                }

                HBPrimaryPillButton(title: "Load into mixer", systemImage: "arrow.down.circle") {
                    store.clearMix()
                    for id in current.ingredientIds {
                        store.addToMix(ingredientId: id)
                    }
                    store.selectedTab = 1
                }

                if hasMissingIngredients {
                    Text("Only ingredients currently in your bar will load into the mix.")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(HBColor.secondary)
                }
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(item: shareText) {
                    Image(systemName: "square.and.arrow.up")
                }

                Button {
                    store.duplicateRecipe(id: current.id)
                } label: {
                    Image(systemName: "doc.on.doc")
                }
                .accessibilityLabel("Duplicate recipe")
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private var hasMissingIngredients: Bool {
        current.ingredientIds.contains { id in !store.ingredients.contains(where: { $0.id == id }) }
    }

    private var missingSubstitutionBlocks: [(missingName: String, swaps: [Ingredient])] {
        var out: [(String, [Ingredient])] = []
        for id in current.ingredientIds {
            guard store.ingredients.first(where: { $0.id == id }) == nil else { continue }
            let name = current.displayName(for: id, pantry: store.ingredients)
            let swaps = SubstitutionEngine.recipeSwaps(missingIngredientName: name, pantry: store.ingredients)
            if !swaps.isEmpty {
                out.append((name, swaps))
            }
        }
        return out
    }

    @ViewBuilder
    private func ingredientBlock(for id: UUID) -> some View {
        let resolved = store.ingredients.first(where: { $0.id == id })
        let name = current.displayName(for: id, pantry: store.ingredients)

        if let ing = resolved {
            HBIngredientCapsule(
                name: ing.name,
                accent: ing.category.accent,
                emoji: ing.category.emoji
            )
        } else {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("⚠️ \(name)")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(HBColor.structure)
                    Spacer()
                    Button("Add to list") {
                        store.addShoppingItem(title: name, source: current.title)
                    }
                    .font(.caption.weight(.bold))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(HBColor.citrusGlow.opacity(0.35))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .strokeBorder(HBColor.structure.opacity(0.14), lineWidth: 1)
                        }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            recipe: Recipe(
                title: "Demo",
                subtitle: "Sample",
                ingredientIds: [],
                steps: ["Step 1"],
                isFavorite: true
            )
        )
        .environmentObject(AppDataStore())
        .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
