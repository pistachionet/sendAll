import SwiftUI
import Contacts

struct ContactPickerView: View {
    @Bindable private var contactService = ContactService.shared
    @Binding var selectedRecipients: [Recipient]
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    // Filtered contacts based on search
    var filteredContacts: [Recipient] {
        if searchText.isEmpty {
            return contactService.contacts
        } else {
            return contactService.contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if contactService.authorizationStatus == .notDetermined {
                    Button("Load Contacts") {
                        Task {
                            await contactService.requestAccess()
                        }
                    }
                } else if contactService.authorizationStatus == .denied {
                    Text("Access denied. Please enable in Settings.")
                        .foregroundStyle(.red)
                } else if contactService.contacts.isEmpty && contactService.authorizationStatus == .authorized {
                    HStack {
                        ProgressView()
                        Text("Loading contacts...")
                            .foregroundStyle(.secondary)
                    }
                }
                
                ForEach(filteredContacts, id: \.id) { recipient in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipient.name)
                                .font(.headline)
                            Text(recipient.phoneNumber)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if selectedRecipients.contains(where: { $0.phoneNumber == recipient.phoneNumber }) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleSelection(for: recipient)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Name")
            .navigationTitle("Select Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 6) {
                            if !selectedRecipients.isEmpty {
                                Text("\(selectedRecipients.count)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                            }
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                // Floating Done button - always visible when there are selections
                if !selectedRecipients.isEmpty {
                    Button(action: { dismiss() }) {
                        HStack {
                            Text("Done")
                                .fontWeight(.semibold)
                            Text("(\(selectedRecipients.count) selected)")
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .blue.opacity(0.4), radius: 8, y: 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .background(.ultraThinMaterial)
                }
            }
        }
        .onAppear {
            contactService.checkPermission()
            if contactService.authorizationStatus == .authorized && contactService.contacts.isEmpty {
                contactService.fetchContacts()
            }
        }
    }
    
    private func toggleSelection(for recipient: Recipient) {
        if let index = selectedRecipients.firstIndex(where: { $0.phoneNumber == recipient.phoneNumber }) {
            selectedRecipients.remove(at: index)
        } else {
            selectedRecipients.append(recipient)
        }
    }
}

