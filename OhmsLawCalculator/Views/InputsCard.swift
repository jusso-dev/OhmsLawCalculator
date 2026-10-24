import SwiftUI

struct InputsCard: View {
    @Environment(OhmsCalculator.self) private var calculator
    @FocusState.Binding var focusedField: OhmVariable?

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.m) {
            HStack {
                Text("Inputs")
                    .font(.headline)
                Spacer()
                Button(action: clear) {
                    Text("Clear")
                        .frame(minWidth: 44, minHeight: 44, alignment: .trailing)
                        .contentShape(Rectangle())
                }
                .font(.subheadline)
                .disabled(!hasAnyInput)
            }

            VStack(spacing: Theme.Spacing.s) {
                ForEach(calculator.inputs) { variable in
                    InputField(
                        variable: variable,
                        value: calculator.binding(for: variable),
                        focusedField: $focusedField
                    )
                }
            }
        }
        .padding(Theme.Spacing.m)
        .background {
            RoundedRectangle(cornerRadius: Theme.Radius.card)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
        }
    }

    private var hasAnyInput: Bool {
        calculator.inputs.contains { calculator.value(for: $0) != nil }
    }

    private func clear() {
        calculator.reset()
        focusedField = nil
    }
}

#Preview {
    @Previewable @FocusState var focused: OhmVariable?
    return InputsCard(focusedField: $focused)
        .environment(OhmsCalculator())
        .padding()
}
