import SwiftUI
import Observation

@MainActor
@Observable
final class OhmsCalculator {
    var target: OhmVariable = .voltage

    var voltage: Double? = nil
    var current: Double? = nil
    var resistance: Double? = nil
    var power: Double? = nil

    var inputs: [OhmVariable] {
        OhmVariable.allCases.filter { $0 != target }
    }

    func value(for variable: OhmVariable) -> Double? {
        switch variable {
        case .voltage: voltage
        case .current: current
        case .resistance: resistance
        case .power: power
        }
    }

    func binding(for variable: OhmVariable) -> Binding<Double?> {
        Binding(
            get: { self.value(for: variable) },
            set: { self.setValue($0, for: variable) }
        )
    }

    private func setValue(_ newValue: Double?, for variable: OhmVariable) {
        switch variable {
        case .voltage: voltage = newValue
        case .current: current = newValue
        case .resistance: resistance = newValue
        case .power: power = newValue
        }
    }

    func reset() {
        voltage = nil
        current = nil
        resistance = nil
        power = nil
    }

    var result: OhmResult? {
        let v = voltage
        let i = current
        let r = resistance
        let p = power

        switch target {
        case .voltage:
            if let i, let r { return .init(value: i * r, formula: "V = I × R") }
            if let p, let i, i != 0 { return .init(value: p / i, formula: "V = P ÷ I") }
            if let p, let r, p >= 0, r > 0 { return .init(value: (p * r).squareRoot(), formula: "V = √(P × R)") }
        case .current:
            if let v, let r, r != 0 { return .init(value: v / r, formula: "I = V ÷ R") }
            if let p, let v, v != 0 { return .init(value: p / v, formula: "I = P ÷ V") }
            if let p, let r, p >= 0, r > 0 { return .init(value: (p / r).squareRoot(), formula: "I = √(P ÷ R)") }
        case .resistance:
            if let v, let i, i != 0 { return .init(value: v / i, formula: "R = V ÷ I") }
            if let v, let p, p != 0 { return .init(value: (v * v) / p, formula: "R = V² ÷ P") }
            if let p, let i, i != 0 { return .init(value: p / (i * i), formula: "R = P ÷ I²") }
        case .power:
            if let v, let i { return .init(value: v * i, formula: "P = V × I") }
            if let i, let r { return .init(value: i * i * r, formula: "P = I² × R") }
            if let v, let r, r != 0 { return .init(value: (v * v) / r, formula: "P = V² ÷ R") }
        }
        return nil
    }
}
