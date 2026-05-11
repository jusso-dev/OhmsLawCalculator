import SwiftUI

enum OhmVariable: String, CaseIterable, Identifiable {
    case voltage, current, resistance, power

    var id: Self { self }

    var symbol: String {
        switch self {
        case .voltage: "V"
        case .current: "I"
        case .resistance: "R"
        case .power: "P"
        }
    }

    var title: String {
        switch self {
        case .voltage: "Voltage"
        case .current: "Current"
        case .resistance: "Resistance"
        case .power: "Power"
        }
    }

    var unit: String {
        switch self {
        case .voltage: "V"
        case .current: "A"
        case .resistance: "Ω"
        case .power: "W"
        }
    }

    var unitName: String {
        switch self {
        case .voltage: "Volts"
        case .current: "Amps"
        case .resistance: "Ohms"
        case .power: "Watts"
        }
    }

    var tint: Color {
        switch self {
        case .voltage: .blue
        case .current: .orange
        case .resistance: .purple
        case .power: .pink
        }
    }

    var systemImage: String {
        switch self {
        case .voltage: "bolt.fill"
        case .current: "wave.3.right"
        case .resistance: "alternatingcurrent"
        case .power: "flame.fill"
        }
    }
}
