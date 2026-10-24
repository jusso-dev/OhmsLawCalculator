import SwiftUI

enum Theme {
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Radius {
        static let card: CGFloat = 20
        static let chip: CGFloat = 14
        static let field: CGFloat = 14
    }

    /// Window width at which the calculator splits into two columns.
    static let twoColumnMinWidth: CGFloat = 720

    static func resultFormat(for value: Double) -> FloatingPointFormatStyle<Double> {
        let magnitude = abs(value)
        if magnitude >= 1e9 {
            return .number.notation(.scientific).precision(.significantDigits(1...4))
        }
        if magnitude < 1 {
            return .number.precision(.significantDigits(1...4))
        }
        return .number.precision(.fractionLength(0...4))
    }
}
