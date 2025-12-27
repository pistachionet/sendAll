import Foundation
import Contacts

@Observable
class ContactService {
    static let shared = ContactService()
    
    var contacts: [Recipient] = []
    var authorizationStatus: CNAuthorizationStatus = .notDetermined
    
    private let store = CNContactStore()
    
    func checkPermission() {
        authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    }
    
    func requestAccess() async {
        do {
            let granted = try await store.requestAccess(for: .contacts)
            DispatchQueue.main.async {
                self.authorizationStatus = granted ? .authorized : .denied
                if granted {
                    self.fetchContacts()
                }
            }
        } catch {
            print("Error requesting contact access: \(error)")
        }
    }
    
    func fetchContacts() {
        DispatchQueue.global(qos: .userInitiated).async {
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            var fetchedRecipients: [Recipient] = []
            
            do {
                try self.store.enumerateContacts(with: request) { contact, stop in
                    // Only add contacts with phone numbers
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
                        // Basic cleanup of phone number can happen here or later
                        let recipient = Recipient(
                            name: fullName.isEmpty ? "No Name" : fullName,
                            phoneNumber: phoneNumber,
                            source: .contact
                        )
                        fetchedRecipients.append(recipient)
                    }
                }
                
                DispatchQueue.main.async {
                    self.contacts = fetchedRecipients.sorted(by: { $0.name < $1.name })
                }
            } catch {
                print("Failed to fetch contacts: \(error)")
            }
        }
    }
}
