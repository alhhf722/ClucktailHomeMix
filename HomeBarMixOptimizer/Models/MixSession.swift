
import Foundation

struct MixSession: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var createdAt: Date
    var ingredientIds: [UUID]
    var title: String
    var note: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        ingredientIds: [UUID],
        title: String,
        note: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.ingredientIds = ingredientIds
        self.title = title
        self.note = note
    }
}
