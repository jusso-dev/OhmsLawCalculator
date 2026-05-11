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

    static let resultFormat: FloatingPointFormatStyle<Double> = .number
        .precision(.fractionLength(0...4))
}
