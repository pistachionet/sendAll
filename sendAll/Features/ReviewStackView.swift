import SwiftUI
import UIKit
import MessageUI

struct ReviewStackView: View {
    let recipients: [Recipient]
    let messageText: String
    
    @State private var currentIndex: Int = 0
    @State private var showMessageComposer = false
    @State private var sentCount = 0
    @State private var skippedCount = 0
    
    // Store customized messages per recipient (by ID)
    @State private var customMessages: [UUID: String] = [:]
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isEditing: Bool
    
    // Get message for current recipient (custom or default)
    private func getMessage(for recipient: Recipient) -> String {
        return customMessages[recipient.id] ?? messageText
    }
    
    // Get binding to message for current recipient
    private func messageBinding(for recipient: Recipient) -> Binding<String> {
        Binding(
            get: { customMessages[recipient.id] ?? messageText },
            set: { customMessages[recipient.id] = $0 }
        )
    }
    
    var body: some View {
        ZStack {
            Color.clear.liquidBackground().ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress Header
                if !recipients.isEmpty && currentIndex < recipients.count {
                    HStack {
                        Text("\(currentIndex + 1) of \(recipients.count)")
                            .font(.headline)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(recipients.count - currentIndex) remaining")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                }
                
                Spacer()
                
                if recipients.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .font(.system(size: 60))
                            .foregroundStyle(.white.opacity(0.5))
                        Text("No recipients selected")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                } else if currentIndex >= recipients.count {
                    // Completion View
                    VStack(spacing: 24) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.green)
                            .shadow(color: .green.opacity(0.5), radius: 20)
                        
                        Text("All Done!")
                            .font(.system(.largeTitle, design: .rounded).bold())
                            .foregroundStyle(.white)
                        
                        HStack(spacing: 40) {
                            VStack {
                                Text("\(sentCount)")
                                    .font(.title.bold())
                                    .foregroundStyle(.green)
                                Text("Sent")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            
                            VStack {
                                Text("\(skippedCount)")
                                    .font(.title.bold())
                                    .foregroundStyle(.orange)
                                Text("Skipped")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        }
                        
                        Button(action: { dismiss() }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.liquidBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 16)
                    }
                } else {
                    // Current recipient card
                    let recipient = recipients[currentIndex]
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("To")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(recipient.name)
                                    .font(.title3.bold())
                            }
                            Spacer()
                            Text(recipient.phoneNumber)
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                        }
                        
                        Divider()
                        
                        // Editable message
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Message")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                if isEditing {
                                    Button("Done") {
                                        isEditing = false
                                    }
                                    .font(.caption.bold())
                                    .foregroundStyle(.blue)
                                } else {
                                    Text("Tap to edit")
                                        .font(.caption)
                                        .foregroundStyle(.blue.opacity(0.7))
                                }
                            }
                            
                            TextEditor(text: messageBinding(for: recipient))
                                .scrollContentBackground(.hidden)
                                .font(.body)
                                .frame(minHeight: 120)
                                .focused($isEditing)
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                    .frame(height: 320)
                    .frame(maxWidth: .infinity)
                    .glass(cornerRadius: 28)
                    .padding(.horizontal)
                    .onTapGesture {
                        // Allow tapping card to start editing
                    }
                    
                    Spacer()
                    
                    // Buttons
                    if !isEditing {
                        HStack(spacing: 50) {
                            Button(action: goBack) {
                                VStack(spacing: 8) {
                                    Image(systemName: "backward.fill")
                                        .font(.title2)
                                        .frame(width: 60, height: 60)
                                        .background(Color.white.opacity(0.15))
                                        .clipShape(Circle())
                                    Text("Back")
                                        .font(.caption)
                                }
                                .foregroundStyle(.white.opacity(0.8))
                            }
                            .disabled(currentIndex == 0)
                            .opacity(currentIndex == 0 ? 0.4 : 1)
                            
                            Button(action: { showMessageComposer = true }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "paperplane.fill")
                                        .font(.title)
                                        .frame(width: 80, height: 80)
                                        .background(Color.liquidBlue)
                                        .clipShape(Circle())
                                        .shadow(color: .blue.opacity(0.5), radius: 15)
                                    Text("Send")
                                        .font(.caption.bold())
                                }
                                .foregroundStyle(.white)
                            }
                            
                            Button(action: skip) {
                                VStack(spacing: 8) {
                                    Image(systemName: "forward.end.fill")
                                        .font(.title2)
                                        .frame(width: 60, height: 60)
                                        .background(Color.white.opacity(0.15))
                                        .clipShape(Circle())
                                    Text("Skip")
                                        .font(.caption)
                                }
                                .foregroundStyle(.white.opacity(0.8))
                            }
                        }
                        .padding(.bottom, 50)
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .sheet(isPresented: $showMessageComposer) {
            let recipient = recipients[currentIndex]
            MessageComposerView(
                recipients: [recipient.phoneNumber],
                body: getMessage(for: recipient)
            ) { result in
                if result == .sent {
                    sentCount += 1
                } else {
                    skippedCount += 1
                }
                withAnimation {
                    currentIndex += 1
                }
            }
        }
    }
    
    private func skip() {
        skippedCount += 1
        withAnimation {
            currentIndex += 1
        }
    }
    
    private func goBack() {
        guard currentIndex > 0 else { return }
        withAnimation {
            currentIndex -= 1
        }
        if skippedCount > 0 {
            skippedCount -= 1
        }
    }
}
