
import Foundation

struct TasteBalance: Codable, Equatable {
    var sweetness: Double
    var acidity: Double
    var bitterness: Double
    var fizz: Double
    var aroma: Double

    static let neutral = TasteBalance(sweetness: 0.5, acidity: 0.5, bitterness: 0.5, fizz: 0.5, aroma: 0.5)

    func merged(with other: TasteBalance, weight: Double) -> TasteBalance {
        let w = max(0, min(1, weight))
        func lerp(_ a: Double, _ b: Double) -> Double { a * (1 - w) + b * w }
        return TasteBalance(
            sweetness: lerp(sweetness, other.sweetness),
            acidity: lerp(acidity, other.acidity),
            bitterness: lerp(bitterness, other.bitterness),
            fizz: lerp(fizz, other.fizz),
            aroma: lerp(aroma, other.aroma)
        )
    }
}

extension Ingredient {
    var tasteFingerprint: TasteBalance {
        switch category {
        case .juices:
            return TasteBalance(sweetness: 0.62, acidity: 0.55, bitterness: 0.18, fizz: 0.12, aroma: 0.35)
        case .sodas:
            return TasteBalance(sweetness: 0.7, acidity: 0.22, bitterness: 0.12, fizz: 0.85, aroma: 0.25)
        case .syrups:
            return TasteBalance(sweetness: 0.88, acidity: 0.18, bitterness: 0.15, fizz: 0.08, aroma: 0.55)
        case .teasInfusions:
            return TasteBalance(sweetness: 0.25, acidity: 0.22, bitterness: 0.35, fizz: 0.05, aroma: 0.75)
        case .citrus:
            return TasteBalance(sweetness: 0.22, acidity: 0.92, bitterness: 0.28, fizz: 0.05, aroma: 0.62)
        case .fruits:
            return TasteBalance(sweetness: 0.58, acidity: 0.45, bitterness: 0.12, fizz: 0.05, aroma: 0.5)
        case .spices:
            return TasteBalance(sweetness: 0.12, acidity: 0.18, bitterness: 0.45, fizz: 0.05, aroma: 0.9)
        case .bittersAromatics:
            return TasteBalance(sweetness: 0.18, acidity: 0.28, bitterness: 0.72, fizz: 0.05, aroma: 0.85)
        case .iceGarnish:
            return TasteBalance(sweetness: 0.05, acidity: 0.05, bitterness: 0.05, fizz: 0.12, aroma: 0.15)
        }
    }
}
