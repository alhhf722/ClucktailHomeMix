
import Foundation

struct Recipe: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var title: String
    var subtitle: String
    var ingredientIds: [UUID]
    var steps: [String]
    var createdAt: Date
    var isFavorite: Bool
    var ingredientNamesSnapshot: [UUID: String]?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        ingredientIds: [UUID],
        steps: [String],
        createdAt: Date = Date(),
        isFavorite: Bool = false,
        ingredientNamesSnapshot: [UUID: String]? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.ingredientIds = ingredientIds
        self.steps = steps
        self.createdAt = createdAt
        self.isFavorite = isFavorite
        self.ingredientNamesSnapshot = ingredientNamesSnapshot
    }

    func displayName(for ingredientId: UUID, pantry: [Ingredient]) -> String {
        if let ing = pantry.first(where: { $0.id == ingredientId }) {
            return ing.name
        }
        if let snap = ingredientNamesSnapshot?[ingredientId] {
            return snap
        }
        return "Recipe ingredient"
    }
}
