import SwiftUI

struct InputField: View {
    let variable: OhmVariable
    @Binding var value: Double?
    @FocusState.Binding var focusedField: OhmVariable?
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ScaledMetric(relativeTo: .subheadline) private var iconWidth: CGFloat = 24

    var body: some View {
        // Stack the label above the value at accessibility sizes so neither is squeezed.
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: Theme.Spacing.s))
            : AnyLayout(HStackLayout(spacing: Theme.Spacing.m))

        layout {
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
                    .frame(width: iconWidth)
            }
            .layoutPriority(1)

            HStack(spacing: Theme.Spacing.m) {
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
        .onTapGesture { focusedField = variable }
        .accessibilityElement(children: .combine)
    }
}
