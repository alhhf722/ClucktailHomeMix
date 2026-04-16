
import Foundation

enum PantryTemplate: String, CaseIterable, Identifiable, Hashable {
    case citrusFizz
    case tropical
    case cozySpice
    case cleanGarden

    var id: String { rawValue }

    var title: String {
        switch self {
        case .citrusFizz: return "Citrus + bubbles"
        case .tropical: return "Tropics"
        case .cozySpice: return "Cozy spices"
        case .cleanGarden: return "Garden fresh"
        }
    }

    var items: [(String, IngredientCategory)] {
        switch self {
        case .citrusFizz:
            return [
                ("Lime", .citrus),
                ("Lemon", .citrus),
                ("Tonic", .sodas),
                ("Club soda", .sodas),
                ("Mint syrup", .syrups),
            ]
        case .tropical:
            return [
                ("Pineapple juice", .juices),
                ("Mango", .fruits),
                ("Coconut milk", .juices),
                ("Lime", .citrus),
            ]
        case .cozySpice:
            return [
                ("Ginger ale", .sodas),
                ("Cinnamon syrup", .syrups),
                ("Fresh ginger", .spices),
                ("Lemon", .citrus),
            ]
        case .cleanGarden:
            return [
                ("Cucumber", .fruits),
                ("Basil", .spices),
                ("Club soda", .sodas),
                ("Lime", .citrus),
            ]
        }
    }
}
