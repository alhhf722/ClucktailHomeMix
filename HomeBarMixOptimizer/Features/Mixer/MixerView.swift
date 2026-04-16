
import SwiftUI

struct MixerView: View {
    @EnvironmentObject private var store: AppDataStore
    @Environment(\.hbAppTheme) private var theme

    @State private var isGlassTargeted = false
    @State private var wiggle = false
    @State private var showingSave = false
    @State private var recipeTitle = ""
    @State private var showClearDialog = false

    private var balanceRows: [(reason: String, ingredients: [Ingredient])] {
        SubstitutionEngine.mixBalanceAdditions(
            pantry: store.ingredients,
            mixIds: store.mixIngredientIds,
            balance: store.estimatedBalance,
            prefersLessSugar: store.preferences.prefersLessSugar,
            dislikesBitter: store.preferences.dislikesBitter,
            wantsSparkling: store.preferences.defaultSparkling
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HBHeroHeader(
                    title: "Mixer",
                    subtitle: "Drag capsules into the glass — the blend color comes alive and hints follow the balance.",
                    systemImage: "sparkles"
                )

                mixGlass

                if !store.mixIngredientIds.isEmpty {
                    mixChips
                }

                HBTasteBalanceStrip(balance: store.estimatedBalance)

                hintCard

                if !balanceRows.isEmpty && !store.mixIngredientIds.isEmpty {
                    substitutionsBlock
                }

                HStack(spacing: 12) {
                    HBPrimaryPillButton(title: "Optimize", systemImage: "wand.and.stars") {
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.72)) {
                            store.optimizeMixSuggestion()
                        }
                    }

                    Button {
                        if store.mixIngredientIds.isEmpty {
                            store.clearMix()
                        } else {
                            showClearDialog = true
                        }
                    } label: {
                        Text("Clear")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(HBColor.structure)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(Color.white)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                                            .strokeBorder(HBColor.structure.opacity(0.18), lineWidth: 1)
                                    }
                            }
                    }
                    .buttonStyle(.plain)
                }

                HStack(spacing: 12) {
                    HBPrimaryPillButton(title: "Save to history", systemImage: "clock.arrow.circlepath") {
                        store.saveCurrentMixToHistory()
                    }
                    .disabled(store.mixIngredients.isEmpty)
                    .opacity(store.mixIngredients.isEmpty ? 0.45 : 1)

                    NavigationLink {
                        MixHistoryView()
                    } label: {
                        Text("Sessions")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(HBColor.structure)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(Color.white)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                                            .strokeBorder(HBColor.structure.opacity(0.18), lineWidth: 1)
                                    }
                            }
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                pantryBubbles

                HBPrimaryPillButton(title: "Save as recipe", systemImage: "square.and.arrow.down") {
                    recipeTitle = suggestedRecipeTitle
                    showingSave = true
                }
                .disabled(store.mixIngredients.isEmpty)
                .opacity(store.mixIngredients.isEmpty ? 0.45 : 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Mixer")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                wiggle = true
            }
        }
        .confirmationDialog("Clear the mix?", isPresented: $showClearDialog, titleVisibility: .visible) {
            Button("Save to history and clear") {
                store.saveCurrentMixToHistory()
                withAnimation(.easeInOut(duration: 0.25)) {
                    store.clearMix()
                }
            }
            Button("Clear only", role: .destructive) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    store.clearMix()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("History helps you revisit great combos even when you didn’t save a recipe.")
        }
        .alert("Save recipe", isPresented: $showingSave) {
            TextField("Title", text: $recipeTitle)
            Button("Save") {
                let title = recipeTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !title.isEmpty else { return }
                store.saveMixAsRecipe(title: title)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("We’ll save the current blend and build steps as a starter for your home bar.")
        }
    }

    private var suggestedRecipeTitle: String {
        let names = store.mixIngredients.map(\.name)
        if names.isEmpty { return "" }
        if names.count <= 2 { return names.joined(separator: " + ") }
        return "\(names.prefix(2).joined(separator: " + ")) + \(names.count - 2) more"
    }

    private var mixGlass: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Glass")
                .font(.headline)
                .foregroundStyle(HBColor.structure)

            ZStack {
                RoundedRectangle(cornerRadius: 34, style: .continuous)
                    .fill(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 34, style: .continuous)
                            .strokeBorder(HBColor.structure.opacity(0.14), lineWidth: 1)
                    }
                    .shadow(color: HBColor.structure.opacity(0.12), radius: 18, x: 0, y: 10)

                MixLiquidLayers(ingredients: store.mixIngredients)
                    .padding(14)

                VStack {
                    Spacer()
                    Capsule()
                        .fill(Color.white.opacity(0.55))
                        .frame(width: 120, height: 10)
                        .padding(.bottom, 14)
                }
            }
            .frame(height: 240)
            .scaleEffect(isGlassTargeted ? 1.02 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.72), value: isGlassTargeted)
            .dropDestination(for: String.self) { items, _ in
                guard let raw = items.first, let uuid = UUID(uuidString: raw) else { return false }
                withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
                    store.addToMix(ingredientId: uuid)
                }
                return true
            } isTargeted: { targeted in
                isGlassTargeted = targeted
            }
        }
    }

    private var mixChips: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("In the mix")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(HBColor.structure)

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(store.mixIngredients) { ingredient in
                        Button {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
                                store.removeFromMix(ingredientId: ingredient.id)
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Text(ingredient.category.emoji)
                                Text(ingredient.name)
                                    .font(.caption.weight(.bold))
                                    .lineLimit(1)
                                Image(systemName: "xmark.circle.fill")
                                    .font(.caption.weight(.bold))
                            }
                            .foregroundStyle(HBColor.structure)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background {
                                Capsule(style: .continuous)
                                    .fill(Color.white)
                                    .overlay {
                                        Capsule(style: .continuous)
                                            .strokeBorder(HBColor.structure.opacity(0.14), lineWidth: 1)
                                    }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var hintCard: some View {
        HBGlassCard(gradient: theme.hintGradient) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Lab hint")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.white.opacity(0.92))

                Text(store.mixerHint)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var substitutionsBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Swaps & adds from your bar")
                .font(.headline)
                .foregroundStyle(HBColor.structure)

            Text("Tap a capsule to add it to the mix (if it’s not already there).")
                .font(.footnote.weight(.medium))
                .foregroundStyle(HBColor.secondary)

            ForEach(Array(balanceRows.enumerated()), id: \.offset) { _, row in
                VStack(alignment: .leading, spacing: 10) {
                    Text(row.reason)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(HBColor.structure)

                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(row.ingredients) { ing in
                                Button {
                                    store.addToMix(ingredientId: ing.id)
                                } label: {
                                    HBIngredientCapsule(
                                        name: ing.name,
                                        accent: ing.category.accent,
                                        emoji: ing.category.emoji,
                                        isSelected: store.mixIngredientIds.contains(ing.id)
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

    private var pantryBubbles: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Bubbles from your bar")
                .font(.headline)
                .foregroundStyle(HBColor.structure)

            Text("Press and drag into the glass — or add from My bar.")
                .font(.footnote.weight(.medium))
                .foregroundStyle(HBColor.secondary)

            if store.ingredients.isEmpty {
                HBPlaceholderBlock(
                    systemImage: "refrigerator",
                    title: "Bar is empty",
                    message: "Add ingredients in My bar to see bubbles here."
                )
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 10)], spacing: 10) {
                    ForEach(store.ingredients) { ingredient in
                        HBIngredientCapsule(
                            name: ingredient.name,
                            accent: ingredient.category.accent,
                            emoji: ingredient.category.emoji,
                            isSelected: store.mixIngredientIds.contains(ingredient.id)
                        )
                        .rotationEffect(.degrees(wiggle ? 0.6 : -0.6))
                        .animation(
                            .easeInOut(duration: 1.25).repeatForever(autoreverses: true),
                            value: wiggle
                        )
                        .draggable(ingredient.id.uuidString)
                        .contextMenu {
                            Button {
                                store.addToMix(ingredientId: ingredient.id)
                            } label: {
                                Label("Add to mix", systemImage: "plus.circle")
                            }
                        }
                    }
                }
            }
        }
    }
}

private struct MixLiquidLayers: View {
    let ingredients: [Ingredient]

    var body: some View {
        Group {
            if ingredients.isEmpty {
                VStack(spacing: 10) {
                    Text("🫧")
                        .font(.system(size: 44))
                    Text("Waiting for the first layer")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(HBColor.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(liquidGradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.35), lineWidth: 1)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .fill(HBGradient.glassSheen().opacity(0.55))
                            .blendMode(.screen)
                    }
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(ingredients.prefix(4)) { item in
                                Text("\(item.category.emoji) \(item.name)")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(Color.white.opacity(0.92))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background {
                                        Capsule().fill(Color.black.opacity(0.12))
                                    }
                            }
                            if ingredients.count > 4 {
                                Text("+ \(ingredients.count - 4) more")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(Color.white.opacity(0.85))
                            }
                        }
                        .padding(12)
                    }
            }
        }
    }

    private var liquidGradient: LinearGradient {
        let colors = ingredients.map { $0.category.accent } + [HBColor.arcticFizz.opacity(0.35)]
        return LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
    }
}

#Preview {
    NavigationStack {
        MixerView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
