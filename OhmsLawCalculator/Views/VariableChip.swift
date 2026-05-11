import SwiftUI

struct VariableChip: View {
    let variable: OhmVariable
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.s) {
                Image(systemName: variable.systemImage)
                    .font(.title3)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(isSelected ? .white : variable.tint)

                VStack(alignment: .leading, spacing: 0) {
                    Text(variable.title)
                        .font(.subheadline)
                        .bold()
                    Text(variable.symbol)
                        .font(.caption)
                        .foregroundStyle(isSelected ? Color.white.opacity(0.85) : .secondary)
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal, Theme.Spacing.m)
            .padding(.vertical, Theme.Spacing.s + 2)
            .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: Theme.Radius.chip)
                    .fill(isSelected ? AnyShapeStyle(variable.tint.gradient) : AnyShapeStyle(.background.secondary))
            }
            .overlay {
                RoundedRectangle(cornerRadius: Theme.Radius.chip)
                    .strokeBorder(isSelected ? Color.clear : variable.tint.opacity(0.25), lineWidth: 1)
            }
            .foregroundStyle(isSelected ? Color.white : .primary)
            .contentShape(RoundedRectangle(cornerRadius: Theme.Radius.chip))
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Solve for \(variable.title)")
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
}

#Preview {
    VStack {
        VariableChip(variable: .voltage, isSelected: true) {}
        VariableChip(variable: .current, isSelected: false) {}
    }
    .padding()
}
