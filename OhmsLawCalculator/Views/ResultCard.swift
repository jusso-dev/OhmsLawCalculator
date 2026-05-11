import SwiftUI

struct ResultCard: View {
    @Environment(OhmsCalculator.self) private var calculator
    @ScaledMetric(relativeTo: .largeTitle) private var resultFontSize: CGFloat = 56

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Text(calculator.target.title)
                .font(.headline)
                .foregroundStyle(Color.white.opacity(0.85))

            if let result = calculator.result, result.isFinite {
                HStack(alignment: .lastTextBaseline, spacing: Theme.Spacing.s) {
                    Text(result.value, format: Theme.resultFormat)
                        .font(.system(size: resultFontSize, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .contentTransition(.numericText(value: result.value))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)

                    Text(calculator.target.unit)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.white.opacity(0.85))
                }
                .animation(.snappy, value: result.value)

                Label(result.formula, systemImage: "function")
                    .font(.subheadline.monospaced())
                    .padding(.horizontal, Theme.Spacing.m)
                    .padding(.vertical, Theme.Spacing.s)
                    .background {
                        Capsule().fill(Color.white.opacity(0.18))
                    }
            } else {
                Text(emptyMessage)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, Theme.Spacing.s)
            }
        }
        .padding(Theme.Spacing.l)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: Theme.Radius.card)
                .fill(calculator.target.tint.gradient)
                .shadow(color: calculator.target.tint.opacity(0.3), radius: 20, y: 10)
        }
        .foregroundStyle(.white)
        .animation(.easeInOut(duration: 0.3), value: calculator.target)
        .accessibilityElement(children: .combine)
    }

    private var emptyMessage: String {
        "Enter two values to calculate \(calculator.target.title.lowercased())."
    }
}

#Preview {
    let calc = OhmsCalculator()
    calc.current = 2
    calc.resistance = 6
    return ResultCard()
        .environment(calc)
        .padding()
}
