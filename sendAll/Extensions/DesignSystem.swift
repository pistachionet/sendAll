import SwiftUI

// MARK: - Colors
extension Color {
    static let liquidBlue = Color(red: 0.0, green: 0.4, blue: 1.0) // Vibrant Electric Blue
    static let liquidPurple = Color(red: 0.6, green: 0.2, blue: 0.9) // Vibrant Purple
    static let deepOcean = Color(red: 0.0, green: 0.05, blue: 0.2) // Dark background base
}

// MARK: - Modifiers

struct GlassModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial) // The "Glass" physical material
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5) // Soft depth shadow
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white.opacity(0.3), lineWidth: 1) // The "cut glass" edge
            )
    }
}

extension View {
    func glass(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassModifier(cornerRadius: cornerRadius))
    }
    
    func liquidBackground() -> some View {
        self.background(
            ZStack {
                // Base
                Color.deepOcean.ignoresSafeArea()
                
                // Orbs (Static for now, can be animated later)
                Circle()
                    .fill(Color.liquidBlue.opacity(0.4))
                    .frame(width: 300, height: 300)
                    .blur(radius: 80)
                    .offset(x: -100, y: -200)
                
                Circle()
                    .fill(Color.purple.opacity(0.4))
                    .frame(width: 350, height: 350)
                    .blur(radius: 90)
                    .offset(x: 150, y: 100)
            }
        )
    }
}
