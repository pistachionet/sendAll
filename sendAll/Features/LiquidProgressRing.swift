import SwiftUI

struct LiquidProgressRing: View {
    var progress: Double // 0.0 to 1.0
    
    var body: some View {
        ZStack {
            // Background Track
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            // Progress Indicator
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
                .shadow(color: .white.opacity(0.5), radius: 5)
        }
    }
}
