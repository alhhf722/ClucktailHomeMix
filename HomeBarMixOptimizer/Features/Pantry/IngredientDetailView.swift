
import SwiftUI

struct IngredientDetailView: View {
    @EnvironmentObject private var store: AppDataStore
    @State private var showingEditor = false

    let ingredient: Ingredient

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HBGlassCard(gradient: HBGradient.liquidBlend(from: ingredient.category.accent, to: Color.white)) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(ingredient.category.emoji)
                                .font(.largeTitle)
                            Spacer()
                            Button {
                                store.toggleFavorite(ingredientId: ingredient.id)
                            } label: {
                                Image(systemName: currentIngredient.isFavorite ? "star.fill" : "star")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(currentIngredient.isFavorite ? HBColor.citrusGlow : Color.white.opacity(0.9))
                            }
                            .accessibilityLabel("Favorite")
                        }

                        Text(currentIngredient.name)
                            .font(.title2.weight(.bold))
                            .foregroundStyle(HBColor.structure)

                        Text(currentIngredient.category.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(HBColor.secondary)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Notes")
                        .font(.headline)
                        .foregroundStyle(HBColor.structure)

                    Text(currentIngredient.notes.isEmpty ? "No notes yet — add what matters for balance." : currentIngredient.notes)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(HBColor.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .strokeBorder(HBColor.structure.opacity(0.12), lineWidth: 1)
                        }
                }
                .hbCardShadow()

                HBPrimaryPillButton(title: "Add to mix", systemImage: "sparkles") {
                    store.addToMix(ingredientId: currentIngredient.id)
                }

                HBPrimaryPillButton(title: "Edit", systemImage: "pencil") {
                    showingEditor = true
                }
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Ingredient")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showingEditor) {
            NavigationStack {
                IngredientEditorView(ingredient: currentIngredient) { store.upsert($0) }
            }
        }
    }

    private var currentIngredient: Ingredient {
        store.ingredients.first { $0.id == ingredient.id } ?? ingredient
    }
}

#Preview {
    NavigationStack {
        IngredientDetailView(
            ingredient: Ingredient(name: "Lime", category: .citrus, isFavorite: true, notes: "Fresh")
        )
        .environmentObject(AppDataStore())
    }
}
