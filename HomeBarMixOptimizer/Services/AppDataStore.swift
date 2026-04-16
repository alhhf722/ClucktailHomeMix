
import Combine
import Foundation
import SwiftUI

final class AppDataStore: ObservableObject {
    private enum Keys {
        static let onboardingDone = "hb.onboarding.done"
        static let pantry = "hb.pantry.v1"
        static let recipes = "hb.recipes.v2"
        static let prefs = "hb.prefs.v1"
        static let sessions = "hb.sessions.v1"
        static let shopping = "hb.shopping.v1"
        static let recipesLegacy = "hb.recipes.v1"
    }

    @Published private(set) var ingredients: [Ingredient] = []
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var mixSessions: [MixSession] = []
    @Published private(set) var shoppingItems: [ShoppingItem] = []
    @Published var preferences: UserPreferences = .default
    @Published var mixIngredientIds: [UUID] = []
    @Published var mixerHint: String = "Drag bubbles into the glass to start mixing."
    @Published var showOnboarding: Bool
    @Published var selectedTab: Int = 0

    var hbAppTheme: HBAppTheme {
        HBAppTheme(variant: preferences.accentVariant)
    }

    let playlists: [DiscoveryPlaylist] = [
        DiscoveryPlaylist(
            title: "Citrus charge",
            description: "Bright acidity, freshness, and aroma — without sugar overload.",
            emoji: "🍋",
            suggestedIngredientNames: ["Lime", "Grapefruit juice", "Tonic"]
        ),
        DiscoveryPlaylist(
            title: "Three-ingredient tropics",
            description: "Juicy, playful, vacation-on-the-counter vibes.",
            emoji: "🍹",
            suggestedIngredientNames: ["Pineapple juice", "Coconut milk", "Mint syrup"]
        ),
        DiscoveryPlaylist(
            title: "Evening chill",
            description: "Soft sweetness, a hint of bitterness, cozy finish.",
            emoji: "✨",
            suggestedIngredientNames: ["Ginger ale", "Cinnamon syrup", "Lemon"]
        ),
        DiscoveryPlaylist(
            title: "Bubbles & breeze",
            description: "Fizz, cool blue mood, glassy clarity of flavor.",
            emoji: "🫧",
            suggestedIngredientNames: ["Club soda", "Cucumber", "Basil"]
        ),
    ]

    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        showOnboarding = !defaults.bool(forKey: Keys.onboardingDone)
        load()
        if ingredients.isEmpty {
            seedStarterPantry()
        }
        if recipes.isEmpty {
            seedStarterRecipes()
        }
    }

    func completeOnboarding() {
        defaults.set(true, forKey: Keys.onboardingDone)
        showOnboarding = false
    }

    func resetOnboarding() {
        defaults.removeObject(forKey: Keys.onboardingDone)
        showOnboarding = true
    }

    func applyOnboardingSelections(selectedTemplates: Set<PantryTemplate>) {
        var pairs: [(String, IngredientCategory)] = []
        for tpl in PantryTemplate.allCases where selectedTemplates.contains(tpl) {
            pairs.append(contentsOf: tpl.items)
        }
        mergeImportedPairs(pairs, sourceLabel: "Onboarding")
    }

    func upsert(_ ingredient: Ingredient) {
        if let idx = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            ingredients[idx] = ingredient
        } else {
            ingredients.insert(ingredient, at: 0)
        }
        savePantry()
    }

    func deleteIngredients(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
        savePantry()
    }

    func deleteIngredient(id: UUID) {
        ingredients.removeAll { $0.id == id }
        mixIngredientIds.removeAll { $0 == id }
        savePantry()
    }

    func toggleFavorite(ingredientId: UUID) {
        guard let idx = ingredients.firstIndex(where: { $0.id == ingredientId }) else { return }
        ingredients[idx].isFavorite.toggle()
        savePantry()
    }

    func addToMix(ingredientId: UUID) {
        guard ingredients.contains(where: { $0.id == ingredientId }) else { return }
        if !mixIngredientIds.contains(ingredientId) {
            mixIngredientIds.append(ingredientId)
            recomputeMixerHint()
        }
    }

    func removeFromMix(ingredientId: UUID) {
        mixIngredientIds.removeAll { $0 == ingredientId }
        recomputeMixerHint()
    }

    func clearMix() {
        mixIngredientIds.removeAll()
        recomputeMixerHint()
    }

    func restoreMixSession(_ session: MixSession) {
        let valid = session.ingredientIds.filter { id in ingredients.contains(where: { $0.id == id }) }
        mixIngredientIds = valid
        recomputeMixerHint()
        selectedTab = 1
    }

    func saveCurrentMixToHistory(title: String? = nil, note: String = "") {
        let ids = mixIngredientIds
        guard !ids.isEmpty else { return }
        let autoTitle = title ?? mixSessionDefaultTitle
        let session = MixSession(ingredientIds: ids, title: autoTitle, note: note)
        mixSessions.insert(session, at: 0)
        trimSessions()
        saveSessions()
    }

    func deleteMixSession(id: UUID) {
        mixSessions.removeAll { $0.id == id }
        saveSessions()
    }

    func clearMixSessions() {
        mixSessions.removeAll()
        saveSessions()
    }

    func importPantryText(_ raw: String, replaceDuplicatesByName: Bool) {
        let pairs = PantryLineImporter.parse(raw)
        mergeImportedPairs(pairs, sourceLabel: "Import", replaceDuplicatesByName: replaceDuplicatesByName)
    }

    func applyPantryTemplate(_ template: PantryTemplate) {
        mergeImportedPairs(template.items, sourceLabel: template.title)
    }

    func saveMixAsRecipe(title: String) {
        let ids = mixIngredientIds
        guard !ids.isEmpty else { return }

        let subtitle = "Mix of \(ids.count) ingredients"
        let steps = [
            "Fill the glass with ice (optional).",
            "Combine ingredients and stir gently.",
            "Taste and tweak acidity or sweetness to your liking.",
        ]

        var snap: [UUID: String] = [:]
        for id in ids {
            if let name = ingredients.first(where: { $0.id == id })?.name {
                snap[id] = name
            }
        }

        let recipe = Recipe(
            title: title,
            subtitle: subtitle,
            ingredientIds: ids,
            steps: steps,
            ingredientNamesSnapshot: snap.isEmpty ? nil : snap
        )
        recipes.insert(recipe, at: 0)
        saveRecipes()
    }

    func duplicateRecipe(id: UUID) {
        guard let r = recipes.first(where: { $0.id == id }) else { return }
        var snap = r.ingredientNamesSnapshot ?? [:]
        for iid in r.ingredientIds {
            if snap[iid] == nil, let n = ingredients.first(where: { $0.id == iid })?.name {
                snap[iid] = n
            }
        }
        let copy = Recipe(
            title: r.title + " (copy)",
            subtitle: r.subtitle,
            ingredientIds: r.ingredientIds,
            steps: r.steps,
            isFavorite: false,
            ingredientNamesSnapshot: snap.isEmpty ? nil : snap
        )
        recipes.insert(copy, at: 0)
        saveRecipes()
    }

    func toggleFavorite(recipeId: UUID) {
        guard let idx = recipes.firstIndex(where: { $0.id == recipeId }) else { return }
        recipes[idx].isFavorite.toggle()
        saveRecipes()
    }

    func deleteRecipe(id: UUID) {
        recipes.removeAll { $0.id == id }
        saveRecipes()
    }

    func updatePreferences(_ prefs: UserPreferences) {
        preferences = prefs
        savePrefs()
        recomputeMixerHint()
    }

    func addShoppingItem(title: String, source: String = "") {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if shoppingItems.contains(where: { $0.title.compare(trimmed, options: .caseInsensitive) == .orderedSame }) {
            return
        }
        shoppingItems.insert(ShoppingItem(title: trimmed, source: source), at: 0)
        saveShopping()
    }

    func addMissingPlaylistToShopping(_ playlist: DiscoveryPlaylist) {
        let missing = SubstitutionEngine.missingFromPlaylist(playlist, pantry: ingredients)
        for name in missing {
            addShoppingItem(title: name, source: playlist.title)
        }
    }

    func addMissingRecipeToShopping(_ recipe: Recipe) {
        for id in recipe.ingredientIds where !ingredients.contains(where: { $0.id == id }) {
            let name = recipe.displayName(for: id, pantry: ingredients)
            addShoppingItem(title: name, source: recipe.title)
        }
    }

    func toggleShoppingItem(id: UUID) {
        guard let idx = shoppingItems.firstIndex(where: { $0.id == id }) else { return }
        shoppingItems[idx].isChecked.toggle()
        saveShopping()
    }

    func deleteShoppingItem(id: UUID) {
        shoppingItems.removeAll { $0.id == id }
        saveShopping()
    }

    func removeCheckedShoppingItems() {
        shoppingItems.removeAll { $0.isChecked }
        saveShopping()
    }

    var mixIngredients: [Ingredient] {
        mixIngredientIds.compactMap { id in ingredients.first { $0.id == id } }
    }

    var mixSessionDefaultTitle: String {
        let names = mixIngredients.map(\.name)
        if names.isEmpty { return "Session" }
        if names.count <= 3 { return names.joined(separator: " · ") }
        return names.prefix(3).joined(separator: " · ") + "…"
    }

    var estimatedBalance: TasteBalance {
        let items = mixIngredients
        guard !items.isEmpty else { return .neutral }

        var acc = items[0].tasteFingerprint
        if items.count == 1 { return acc }

        for ingredient in items.dropFirst() {
            acc = acc.merged(with: ingredient.tasteFingerprint, weight: 0.35)
        }

        if preferences.prefersLessSugar {
            acc = TasteBalance(
                sweetness: max(0, acc.sweetness - 0.08),
                acidity: acc.acidity,
                bitterness: acc.bitterness,
                fizz: acc.fizz,
                aroma: acc.aroma
            )
        }

        if preferences.dislikesBitter {
            acc = TasteBalance(
                sweetness: acc.sweetness,
                acidity: acc.acidity,
                bitterness: max(0, acc.bitterness - 0.1),
                fizz: acc.fizz,
                aroma: acc.aroma
            )
        }

        return acc
    }

    func optimizeMixSuggestion() {
        recomputeMixerHint(forceOptimize: true)
    }

    func searchIngredients(query: String) -> [Ingredient] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return ingredients }
        return ingredients.filter { ing in
            ing.name.lowercased().contains(q)
                || ing.notes.lowercased().contains(q)
                || ing.category.title.lowercased().contains(q)
        }
    }

    func searchRecipes(query: String) -> [Recipe] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return recipes }
        return recipes.filter {
            $0.title.lowercased().contains(q) || $0.subtitle.lowercased().contains(q)
        }
    }

    func searchPlaylists(query: String) -> [DiscoveryPlaylist] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return playlists }
        return playlists.filter {
            $0.title.lowercased().contains(q)
                || $0.description.lowercased().contains(q)
                || $0.suggestedIngredientNames.joined().lowercased().contains(q)
        }
    }

    private func recomputeMixerHint(forceOptimize: Bool = false) {
        let items = mixIngredients
        if items.isEmpty {
            mixerHint = "Drag bubbles into the glass to start mixing."
            return
        }

        let b = estimatedBalance

        if b.sweetness > 0.78 {
            mixerHint = "Sweetness is high: add citrus 🍋, a pinch of salt, or dilute with soda or sparkling water."
        } else if b.acidity > 0.82 {
            mixerHint = "Acidity dominates: soften with syrup or fruit, or balance with a sweeter soda."
        } else if b.fizz < 0.25 && preferences.defaultSparkling {
            mixerHint = "Try adding fizz — texture feels livelier and the flavor cleaner."
        } else if b.aroma < 0.35 {
            mixerHint = "Low aroma: spices, herbs, zest, or a few drops of bitters add character."
        } else if forceOptimize {
            mixerHint = "Balance looks solid. Save as a recipe and try a small garnish twist ✨"
        } else {
            mixerHint = "Nice direction. Tweak one knob and you can get a “wow” without new bottles."
        }
    }

    private func mergeImportedPairs(
        _ pairs: [(String, IngredientCategory)],
        sourceLabel: String,
        replaceDuplicatesByName: Bool = false
    ) {
        for (name, category) in pairs {
            if let idx = ingredients.firstIndex(where: { $0.name.compare(name, options: .caseInsensitive) == .orderedSame }) {
                if replaceDuplicatesByName {
                    ingredients[idx].category = category
                    if !sourceLabel.isEmpty, !ingredients[idx].notes.isEmpty {
                        ingredients[idx].notes += "\n• \(sourceLabel)"
                    }
                }
                continue
            }
            ingredients.append(Ingredient(name: name, category: category, notes: sourceLabel.isEmpty ? "" : "From: \(sourceLabel)"))
        }
        savePantry()
    }

    private func trimSessions() {
        if mixSessions.count > 40 {
            mixSessions = Array(mixSessions.prefix(40))
        }
    }

    private func load() {
        if let data = defaults.data(forKey: Keys.pantry),
           let decoded = try? decoder.decode([Ingredient].self, from: data) {
            ingredients = decoded
        }

        if let data = defaults.data(forKey: Keys.recipes),
           let decoded = try? decoder.decode([Recipe].self, from: data) {
            recipes = decoded
        } else if let data = defaults.data(forKey: Keys.recipesLegacy),
                  let decoded = try? decoder.decode([Recipe].self, from: data) {
            recipes = decoded
            saveRecipes()
        }

        if let data = defaults.data(forKey: Keys.sessions),
           let decoded = try? decoder.decode([MixSession].self, from: data) {
            mixSessions = decoded
        }

        if let data = defaults.data(forKey: Keys.shopping),
           let decoded = try? decoder.decode([ShoppingItem].self, from: data) {
            shoppingItems = decoded
        }

        if let data = defaults.data(forKey: Keys.prefs),
           let decoded = try? decoder.decode(UserPreferences.self, from: data) {
            preferences = decoded
        }
    }

    private func savePantry() {
        if let data = try? encoder.encode(ingredients) {
            defaults.set(data, forKey: Keys.pantry)
        }
    }

    private func saveRecipes() {
        if let data = try? encoder.encode(recipes) {
            defaults.set(data, forKey: Keys.recipes)
        }
    }

    private func saveSessions() {
        if let data = try? encoder.encode(mixSessions) {
            defaults.set(data, forKey: Keys.sessions)
        }
    }

    private func saveShopping() {
        if let data = try? encoder.encode(shoppingItems) {
            defaults.set(data, forKey: Keys.shopping)
        }
    }

    private func savePrefs() {
        if let data = try? encoder.encode(preferences) {
            defaults.set(data, forKey: Keys.prefs)
        }
    }

    private func seedStarterPantry() {
        ingredients = [
            Ingredient(name: "Grapefruit juice", category: .juices, isFavorite: true),
            Ingredient(name: "Pineapple juice", category: .juices),
            Ingredient(name: "Tonic", category: .sodas, isFavorite: true),
            Ingredient(name: "Club soda", category: .sodas),
            Ingredient(name: "Ginger ale", category: .sodas),
            Ingredient(name: "Mint syrup", category: .syrups, isFavorite: true),
            Ingredient(name: "Cinnamon syrup", category: .syrups),
            Ingredient(name: "Cold green tea", category: .teasInfusions),
            Ingredient(name: "Lime", category: .citrus, isFavorite: true),
            Ingredient(name: "Lemon", category: .citrus),
            Ingredient(name: "Cucumber", category: .fruits),
            Ingredient(name: "Basil", category: .spices),
            Ingredient(name: "Fresh ginger", category: .spices),
            Ingredient(name: "Aromatic bitters", category: .bittersAromatics),
            Ingredient(name: "Ice cubes", category: .iceGarnish),
        ]
        savePantry()
    }

    private func seedStarterRecipes() {
        guard let lime = ingredients.first(where: { $0.name == "Lime" })?.id,
              let tonic = ingredients.first(where: { $0.name == "Tonic" })?.id,
              let mint = ingredients.first(where: { $0.name == "Mint syrup" })?.id else {
            return
        }

        let snap: [UUID: String] = [lime: "Lime", tonic: "Tonic", mint: "Mint syrup"]

        recipes = [
            Recipe(
                title: "Lime tonic 2.0",
                subtitle: "Fresh, fizzy, easy to dial the sweetness.",
                ingredientIds: [lime, tonic, mint],
                steps: [
                    "Squeeze lime into the glass.",
                    "Add ice and mint syrup to taste.",
                    "Top with tonic and stir gently.",
                ],
                isFavorite: true,
                ingredientNamesSnapshot: snap
            ),
        ]
        saveRecipes()
    }
}
