
import Foundation

enum RecipeShareText {
    static func build(recipe: Recipe, ingredientLines: [String], steps: [String]) -> String {
        var lines: [String] = []
        lines.append("🍹 \(recipe.title)")
        lines.append(recipe.subtitle)
        lines.append("")
        lines.append("Ingredients:")
        for line in ingredientLines {
            lines.append("• \(line)")
        }
        lines.append("")
        lines.append("Steps:")
        for (i, step) in steps.enumerated() {
            lines.append("\(i + 1). \(step)")
        }
        lines.append("")
        lines.append("— Clucktail Home Mix")
        return lines.joined(separator: "\n")
    }
}
