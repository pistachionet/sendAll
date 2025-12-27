import Foundation
import SwiftData

@Model
final class Recipient {
    var id: UUID
    var name: String
    var phoneNumber: String
    var source: RecipientSource
    
    init(id: UUID = UUID(), name: String, phoneNumber: String, source: RecipientSource = .contact) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.source = source
    }
}

enum RecipientSource: String, Codable {
    case contact
    case manual
}
