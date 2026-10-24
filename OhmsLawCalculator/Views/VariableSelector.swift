import SwiftUI

struct VariableSelector: View {
    @Binding var selection: OhmVariable
    // Scales with Dynamic Type so chips drop to one column instead of breaking words.
    @ScaledMetric(relativeTo: .subheadline) private var chipMinWidth: CGFloat = 140

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Text("Solve for")
                .font(.headline)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: chipMinWidth), spacing: Theme.Spacing.s)],
                spacing: Theme.Spacing.s
            ) {
                ForEach(OhmVariable.allCases) { variable in
                    VariableChip(
                        variable: variable,
                        isSelected: selection == variable
                    ) {
                        withAnimation(.spring(duration: 0.35)) {
                            selection = variable
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selection: OhmVariable = .voltage
    return VariableSelector(selection: $selection)
        .padding()
}
