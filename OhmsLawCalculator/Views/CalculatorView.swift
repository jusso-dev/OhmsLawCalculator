import SwiftUI

struct CalculatorView: View {
    @Environment(OhmsCalculator.self) private var calculator
    @FocusState private var focusedField: OhmVariable?
    @State private var isWide = false

    var body: some View {
        @Bindable var bindable = calculator
        // AnyLayout keeps view identity when the window resizes, so focus and typed text survive.
        let columns = isWide
            ? AnyLayout(HStackLayout(alignment: .top, spacing: Theme.Spacing.l))
            : AnyLayout(VStackLayout(spacing: Theme.Spacing.l))

        ZStack {
            BackgroundView(tint: calculator.target.tint)

            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    HeaderView()

                    columns {
                        VStack(spacing: Theme.Spacing.l) {
                            VariableSelector(selection: $bindable.target)

                            ResultCard()
                        }
                        .frame(maxWidth: .infinity, alignment: .top)

                        VStack(spacing: Theme.Spacing.l) {
                            InputsCard(focusedField: $focusedField)

                            FormulaReferenceCard()
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                }
                .padding(Theme.Spacing.m)
            }
            .scrollDismissesKeyboard(.interactively)
            .onGeometryChange(for: Bool.self) { proxy in
                proxy.size.width >= Theme.twoColumnMinWidth
            } action: { isWide = $0 }
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
