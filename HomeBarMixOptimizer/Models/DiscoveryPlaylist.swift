
import Foundation

struct DiscoveryPlaylist: Identifiable, Hashable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let emoji: String
    let suggestedIngredientNames: [String]

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        emoji: String,
        suggestedIngredientNames: [String]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.emoji = emoji
        self.suggestedIngredientNames = suggestedIngredientNames
    }
}
