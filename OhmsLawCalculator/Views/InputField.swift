import SwiftUI

struct InputField: View {
    let variable: OhmVariable
    @Binding var value: Double?
    @FocusState.Binding var focusedField: OhmVariable?

    var body: some View {
        HStack(spacing: Theme.Spacing.m) {
            Label {
                VStack(alignment: .leading, spacing: 0) {
                    Text(variable.title)
                        .font(.subheadline)
                        .bold()
                    Text(variable.unitName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } icon: {
                Image(systemName: variable.systemImage)
                    .foregroundStyle(variable.tint)
                    .frame(width: 24)
            }

            Spacer(minLength: Theme.Spacing.s)

            TextField(variable.symbol, value: $value, format: .number)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused($focusedField, equals: variable)
                .font(.title3.monospacedDigit())
                .frame(minWidth: 80)

            Text(variable.unit)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(minWidth: 24, alignment: .leading)
        }
        .padding(Theme.Spacing.m)
        .frame(minHeight: 44)
        .background {
            RoundedRectangle(cornerRadius: Theme.Radius.field)
                .fill(Color(.secondarySystemBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: Theme.Radius.field)
                .strokeBorder(
                    focusedField == variable ? variable.tint : Color.clear,
                    lineWidth: 1.5
                )
        }
        .animation(.easeInOut(duration: 0.2), value: focusedField)
        .contentShape(RoundedRectangle(cornerRadius: Theme.Radius.field))
        .accessibilityElement(children: .combine)
    }
}
