import SwiftUI

@main
struct OhmsLawCalculatorApp: App {
    @State private var calculator = OhmsCalculator()

    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environment(calculator)
        }
    }
}
