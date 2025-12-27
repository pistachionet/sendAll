import SwiftUI

// Navigation destinations
enum AppDestination: Hashable {
    case composer
    case review(recipients: [Recipient], message: String)
}

struct ContentView: View {
    @State private var selectedRecipients: [Recipient] = []
    @State private var showingContactPicker = false
    @State private var showingManualEntry = false
    
    @State private var messageText = ""
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.clear.liquidBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Beautiful Title Header
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 12) {
                            Image(systemName: "paperplane.fill")
                                .font(.title)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.liquidBlue, Color.liquidPurple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            Text("sendAll")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        
                        Text("send mass texts individually")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.6))
                            .tracking(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    if selectedRecipients.isEmpty {
                        ContentUnavailableView("No Recipients", systemImage: "person.2.slash", description: Text("Add people to start.").foregroundStyle(.white.opacity(0.7)))
                            .foregroundStyle(.white)
                            .glass()
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(selectedRecipients) { recipient in
                                    HStack {
                                        Text(recipient.name)
                                            .font(.system(.body, design: .rounded))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Button {
                                            if let index = selectedRecipients.firstIndex(where: { $0.id == recipient.id }) {
                                                selectedRecipients.remove(at: index)
                                            }
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundStyle(.white.opacity(0.6))
                                        }
                                    }
                                    .padding()
                                    .glass(cornerRadius: 15)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    HStack(spacing: 15) {
                        Button { showingContactPicker = true } label: {
                            Label("Contacts", systemImage: "person.crop.circle")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .glass(cornerRadius: 12)
                        }
                        
                        Button { showingManualEntry = true } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .padding()
                                .frame(width: 56, height: 56)
                                .glass(cornerRadius: 12)
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    
                    if !selectedRecipients.isEmpty {
                        Button {
                            navigationPath.append(AppDestination.composer)
                        } label: {
                            Text("Compose Message")
                                .font(.system(.title3, design: .rounded).bold())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.liquidBlue.opacity(0.8))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(color: .blue.opacity(0.5), radius: 10)
                        }
                        .padding()
                    }
                }
            }
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .composer:
                    ComposerView(messageText: $messageText) {
                        // Capture the current values when navigating
                        let currentRecipients = selectedRecipients
                        let currentMessage = messageText
                        navigationPath.append(AppDestination.review(recipients: currentRecipients, message: currentMessage))
                    }
                case .review(let recipients, let message):
                    ReviewStackView(recipients: recipients, messageText: message)
                }
            }
            .sheet(isPresented: $showingContactPicker) {
                ContactPickerView(selectedRecipients: $selectedRecipients)
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.ultraThinMaterial)
            }
            .sheet(isPresented: $showingManualEntry) {
                ManualEntryView(selectedRecipients: $selectedRecipients)
                    .presentationDetents([.medium])
                    .presentationBackground(.ultraThinMaterial)
            }
        }
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
