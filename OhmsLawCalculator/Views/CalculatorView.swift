import SwiftUI

struct CalculatorView: View {
    @Environment(OhmsCalculator.self) private var calculator
    @FocusState private var focusedField: OhmVariable?

    var body: some View {
        @Bindable var bindable = calculator

        ZStack {
            BackgroundView(tint: calculator.target.tint)

            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    HeaderView()

                    VariableSelector(selection: $bindable.target)

                    InputsCard(focusedField: $focusedField)

                    ResultCard()

                    FormulaReferenceCard()
                }
                .padding(Theme.Spacing.m)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
                    .bold()
            }
        }
        .onChange(of: calculator.target) { _, _ in
            focusedField = nil
        }
    }
}

#Preview {
    CalculatorView()
        .environment(OhmsCalculator())
}
