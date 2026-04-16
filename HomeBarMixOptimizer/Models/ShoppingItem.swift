
import Foundation

struct ShoppingItem: Identifiable, Codable, Hashable, Equatable {
    var id: UUID
    var title: String
    var isChecked: Bool
    var source: String

    init(id: UUID = UUID(), title: String, isChecked: Bool = false, source: String = "") {
        self.id = id
        self.title = title
        self.isChecked = isChecked
        self.source = source
    }
}
