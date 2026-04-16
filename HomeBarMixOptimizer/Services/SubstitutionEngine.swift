
import Foundation

enum SubstitutionEngine {
    static func pantryContains(suggestedName: String, pantry: [Ingredient]) -> Bool {
        let needle = suggestedName.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return pantry.contains { ing in
            let hay = ing.name.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            return hay.contains(needle) || needle.contains(hay)
        }
    }

    static func missingFromPlaylist(_ playlist: DiscoveryPlaylist, pantry: [Ingredient]) -> [String] {
        playlist.suggestedIngredientNames.filter { !pantryContains(suggestedName: $0, pantry: pantry) }
    }

    static func swaps(forMissingName missingName: String, pantry: [Ingredient], limit: Int = 4) -> [Ingredient] {
        let hint = categoryHint(for: missingName)
        let ml = missingName.lowercased()
        let scored = pantry
            .filter { candidate in
                !nameMatches(candidate.name, missingName)
            }
            .map { ing -> (Ingredient, Int) in
                var score = 0
                if ing.category == hint { score += 3 }
                if ing.category == .sodas,
                   ml.contains("tonic") || ml.contains("soda") || ml.contains("fizz") || ml.contains("sparkling") || ml.contains("seltzer") {
                    score += 2
                }
                if ing.isFavorite { score += 1 }
                return (ing, score)
            }
            .filter { $0.1 > 0 }
            .sorted { $0.1 > $1.1 }
            .map(\.0)
        return Array(scored.prefix(limit))
    }

    static func recipeSwaps(
        missingIngredientName: String,
        pantry: [Ingredient]
    ) -> [Ingredient] {
        swaps(forMissingName: missingIngredientName, pantry: pantry, limit: 5)
    }

    static func mixBalanceAdditions(
        pantry: [Ingredient],
        mixIds: [UUID],
        balance: TasteBalance,
        prefersLessSugar: Bool,
        dislikesBitter: Bool,
        wantsSparkling: Bool
    ) -> [(reason: String, ingredients: [Ingredient])] {
        let mixSet = Set(mixIds)
        let candidates = pantry.filter { !mixSet.contains($0.id) }
        var rows: [(String, [Ingredient])] = []

        if balance.sweetness > 0.74 {
            let picks = pick(candidates, categories: [.citrus, .teasInfusions], limit: 3)
            if !picks.isEmpty {
                rows.append(("Sweetness is high — brighten with acidity", picks))
            }
        }

        if balance.acidity > 0.78 {
            let picks = pick(candidates, categories: [.syrups, .sodas, .juices], limit: 3)
            if !picks.isEmpty {
                rows.append(("Acidity is strong — soften with sweetness", picks))
            }
        }

        if balance.fizz < 0.28 && wantsSparkling {
            let picks = pick(candidates, categories: [.sodas], limit: 3)
            if !picks.isEmpty {
                rows.append(("Add bubbles for texture", picks))
            }
        }

        if balance.aroma < 0.38 {
            let picks = pick(candidates, categories: [.spices, .bittersAromatics, .fruits], limit: 3)
            if !picks.isEmpty {
                rows.append(("More aroma and character", picks))
            }
        }

        if prefersLessSugar, balance.sweetness > 0.62 {
            let picks = pick(candidates, categories: [.citrus, .teasInfusions, .sodas], limit: 2)
            if !picks.isEmpty {
                rows.append(("Less sugar — dilute or trim sweetness", picks))
            }
        }

        if dislikesBitter, balance.bitterness > 0.55 {
            let picks = pick(candidates, categories: [.juices, .syrups, .sodas], limit: 2)
            if !picks.isEmpty {
                rows.append(("Soften bitterness with juice or syrup", picks))
            }
        }

        if rows.isEmpty {
            let picks = pick(candidates, categories: [.juices, .sodas, .citrus], limit: 2)
            if !picks.isEmpty {
                rows.append(("Try a new layer", picks))
            }
        }

        return rows
    }

    private static func pick(_ pantry: [Ingredient], categories: [IngredientCategory], limit: Int) -> [Ingredient] {
        pantry.filter { categories.contains($0.category) }.prefix(limit).map(\.self)
    }

    private static func categoryHint(for name: String) -> IngredientCategory {
        let n = name.lowercased()
        if n.contains("lime") || n.contains("lemon") || n.contains("citrus") || n.contains("grapefruit") || n.contains("orange")
            || n.contains("yuzu") || n.contains("tangerine") {
            return .citrus
        }
        if n.contains("juice") || n.contains("nectar") { return .juices }
        if n.contains("ginger ale") || n.contains("gingerale") || n.contains("tonic") || n.contains("soda") || n.contains("cola")
            || n.contains("fizz") || n.contains("sparkling") || n.contains("seltzer") || n.contains("club soda") || n.contains("clubsoda") {
            return .sodas
        }
        if n.contains("syrup") || n.contains("honey") || n.contains("agave") { return .syrups }
        if n.contains("tea") || n.contains("infusion") || n.contains("tisane") { return .teasInfusions }
        if n.contains("coconut") || n.contains("pineapple") || n.contains("berry") || n.contains("mango")
            || n.contains("melon") || n.contains("cherry") || n.contains("strawberry") {
            return .fruits
        }
        if n.contains("cucumber") || n.contains("mint") || n.contains("basil") {
            return .fruits
        }
        if n.contains("bitter") || n.contains("aromatic") {
            return .bittersAromatics
        }
        return .juices
    }

    private static func nameMatches(_ a: String, _ b: String) -> Bool {
        let x = a.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        let y = b.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return x == y || x.contains(y) || y.contains(x)
    }
}
