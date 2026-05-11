import Foundation

struct FormulaEntry: Identifiable {
    let label: String
    let formula: String
    var id: String { formula }
}
