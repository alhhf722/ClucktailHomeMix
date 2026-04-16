
import SwiftUI

enum IngredientCategory: String, CaseIterable, Identifiable, Codable {
    case juices
    case sodas
    case syrups
    case teasInfusions
    case citrus
    case fruits
    case spices
    case bittersAromatics
    case iceGarnish

    var id: String { rawValue }

    var title: String {
        switch self {
        case .juices: return "Juices"
        case .sodas: return "Sodas"
        case .syrups: return "Syrups"
        case .teasInfusions: return "Teas & infusions"
        case .citrus: return "Citrus"
        case .fruits: return "Fruits"
        case .spices: return "Spices"
        case .bittersAromatics: return "Bitters & aromatics"
        case .iceGarnish: return "Ice & garnish"
        }
    }

    var emoji: String {
        switch self {
        case .juices: return "🧃"
        case .sodas: return "🫧"
        case .syrups: return "🍯"
        case .teasInfusions: return "🍵"
        case .citrus: return "🍋"
        case .fruits: return "🍓"
        case .spices: return "✨"
        case .bittersAromatics: return "🌿"
        case .iceGarnish: return "🧊"
        }
    }

    var accent: Color {
        switch self {
        case .juices: return HBColor.citrusGlow
        case .sodas: return HBColor.arcticFizz
        case .syrups: return HBColor.berryPop
        case .teasInfusions: return HBColor.structure.opacity(0.55)
        case .citrus: return HBColor.limeZest
        case .fruits: return HBColor.berryPop.opacity(0.85)
        case .spices: return HBColor.citrusGlow.opacity(0.85)
        case .bittersAromatics: return HBColor.mintMist
        case .iceGarnish: return HBColor.arcticFizz.opacity(0.85)
        }
    }
}
