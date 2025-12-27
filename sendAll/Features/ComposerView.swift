import SwiftUI

struct ComposerView: View {
    @Binding var messageText: String
    var onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.clear.liquidBackground().ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Draft Message")
                    .font(.system(.title2, design: .rounded).bold())
                    .foregroundStyle(.white)
                
                TextEditor(text: $messageText)
                    .scrollContentBackground(.hidden) // Required to make TextEditor transparent
                    .foregroundStyle(.white)
                    .padding()
                    .frame(height: 250)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                
                Button(action: onContinue) {
                    HStack {
                        Text("Review Messages")
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .glass(cornerRadius: 15)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}
