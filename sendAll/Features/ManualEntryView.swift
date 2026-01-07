import SwiftUI

struct ManualEntryView: View {
    @Binding var selectedRecipients: [Recipient]
    @Environment(\.dismiss) var dismiss
    
    @State private var phoneNumber: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .focused($isFocused)
                } header: {
                    Text("Enter phone number")
                } footer: {
                    Text("The phone number will be used as the recipient name")
                }
            }
            .navigationTitle("Add Number")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addRecipient()
                    }
                    .fontWeight(.semibold)
                    .disabled(phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                isFocused = true
            }
        }
        }
        .tint(Color.liquidBlue)
    }
    
    private func addRecipient() {
        let cleanNumber = phoneNumber.trimmingCharacters(in: .whitespaces)
        guard !cleanNumber.isEmpty else { return }
        let recipient = Recipient(name: cleanNumber, phoneNumber: cleanNumber, source: .manual)
        selectedRecipients.append(recipient)
        dismiss()
    }
}
