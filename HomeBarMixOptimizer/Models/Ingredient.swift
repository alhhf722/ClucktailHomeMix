
import Foundation

struct Ingredient: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var name: String
    var category: IngredientCategory
    var isFavorite: Bool
    var notes: String

    init(
        id: UUID = UUID(),
        name: String,
        category: IngredientCategory,
        isFavorite: Bool = false,
        notes: String = ""
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.isFavorite = isFavorite
        self.notes = notes
    }
}
