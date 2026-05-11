import SwiftUI

struct BackgroundView: View {
    let tint: Color

    var body: some View {
        LinearGradient(
            colors: [
                tint.opacity(0.35),
                Color(.systemBackground),
                Color(.systemBackground)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.5), value: tint)
    }
}
