
import Foundation

struct UserPreferences: Codable, Equatable {
    var prefersLessSugar: Bool
    var dislikesBitter: Bool
    var defaultSparkling: Bool
    var accentVariant: AccentVariant

    static let `default` = UserPreferences(
        prefersLessSugar: false,
        dislikesBitter: false,
        defaultSparkling: true,
        accentVariant: .lime
    )
}

enum AccentVariant: String, Codable, CaseIterable, Identifiable {
    case lime
    case mint
    case arctic

    var id: String { rawValue }

    var title: String {
        switch self {
        case .lime: return "Lime"
        case .mint: return "Mint"
        case .arctic: return "Arctic fizz"
        }
    }
}
