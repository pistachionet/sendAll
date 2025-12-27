import Foundation
import SwiftData

@Model
final class BroadcastList {
    var id: UUID
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var recipients: [Recipient]
    
    init(id: UUID = UUID(), name: String, createdAt: Date = Date(), recipients: [Recipient] = []) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.recipients = recipients
    }
}
