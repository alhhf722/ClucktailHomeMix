
import Foundation

enum PantryLineImporter {
    static func parse(_ raw: String) -> [(String, IngredientCategory)] {
        var tokens: [String] = []
        for line in raw.split(whereSeparator: \.isNewline) {
            let parts = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            tokens.append(contentsOf: parts)
        }

        var seen = Set<String>()
        var result: [(String, IngredientCategory)] = []
        for token in tokens {
            let t = token.trimmingCharacters(in: .whitespacesAndNewlines)
            guard t.count >= 2 else { continue }
            let key = t.lowercased()
            guard !seen.contains(key) else { continue }
            seen.insert(key)
            result.append((t, guessCategory(for: t)))
        }
        return result
    }

    private static func guessCategory(for name: String) -> IngredientCategory {
        let n = name.lowercased()
        if n.contains("lime") || n.contains("lemon") || n.contains("grapefruit") || n.contains("orange")
            || n.contains("citrus") || n.contains("yuzu") || n.contains("tangerine") || n.contains("mandarin") {
            return .citrus
        }
        if n.contains("ginger ale") || n.contains("gingerale") || n.contains("tonic") || n.contains("soda")
            || n.contains("cola") || n.contains("sparkling") || n.contains("seltzer") || n.contains("fizz")
            || n.contains("club soda") || n.contains("clubsoda") || n.contains("root beer") || n.contains("cream soda") {
            return .sodas
        }
        if n.contains("syrup") || n.contains("agave") || n.contains("honey") || n.contains("cordial") {
            return .syrups
        }
        if n.contains("tea") || n.contains("infusion") || n.contains("tisane") {
            return .teasInfusions
        }
        if n.contains("cucumber") || n.contains("strawberry") || n.contains("mango") || n.contains("pineapple")
            || n.contains("berry") || n.contains("melon") || n.contains("watermelon") || n.contains("cherry") {
            return .fruits
        }
        if n.contains("cinnamon") || n.contains("ginger") || n.contains("clove") || n.contains("basil") || n.contains("mint")
            || n.contains("nutmeg") || n.contains("vanilla") || n.contains("rosemary") || n.contains("thyme") {
            return .spices
        }
        if n.contains("bitter") || n.contains("aromatic") {
            return .bittersAromatics
        }
        if n.contains("ice") || n.contains("garnish") {
            return .iceGarnish
        }
        if n.contains("juice") || n.contains("nectar") {
            return .juices
        }
        return .juices
    }
}
