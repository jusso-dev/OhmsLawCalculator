import SwiftUI

struct FormulaReferenceCard: View {
    private let formulas: [FormulaEntry] = [
        .init(label: "Voltage", formula: "V = I × R"),
        .init(label: "Current", formula: "I = V ÷ R"),
        .init(label: "Resistance", formula: "R = V ÷ I"),
        .init(label: "Power", formula: "P = V × I"),
        .init(label: "Power (I, R)", formula: "P = I² × R"),
        .init(label: "Power (V, R)", formula: "P = V² ÷ R")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Label("Formulas", systemImage: "book.closed")
                .font(.headline)

            VStack(spacing: 0) {
                ForEach(formulas) { entry in
                    HStack {
                        Text(entry.label)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(entry.formula)
                            .font(.subheadline.monospaced())
                            .bold()
                    }
                    .padding(.vertical, Theme.Spacing.s)

                    if entry.id != formulas.last?.id {
                        Divider()
                    }
                }
            }
        }
        .padding(Theme.Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: Theme.Radius.card)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
        }
    }
}

#Preview {
    FormulaReferenceCard().padding()
}
