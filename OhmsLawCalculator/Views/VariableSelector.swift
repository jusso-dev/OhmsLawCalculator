import SwiftUI

struct VariableSelector: View {
    @Binding var selection: OhmVariable

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Text("Solve for")
                .font(.headline)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 140), spacing: Theme.Spacing.s)],
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
