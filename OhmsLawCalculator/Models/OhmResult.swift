import Foundation

struct OhmResult: Equatable {
    let value: Double
    let formula: String

    var isFinite: Bool { value.isFinite }
}
