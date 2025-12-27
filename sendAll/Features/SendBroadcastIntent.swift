import AppIntents
import MessageUI

struct SendBroadcastIntent: AppIntent {
    static var title: LocalizedStringResource = "Send Broadcast"
    static var description = IntentDescription("Sends a message to a list of recipients individually.")
    
    @Parameter(title: "Recipients")
    var recipients: [String]
    
    @Parameter(title: "Message")
    var message: String
    
    init() {}
    
    init(recipients: [String], message: String) {
        self.recipients = recipients
        self.message = message
    }
    
    func perform() async throws -> some IntentResult {
        // NOTE: In a real App Intent, we cannot present UI (like MFMessageComposeViewController) directly
        // without user interaction if we want it fully backgrounded, BUT for "Zap Mode"
        // we essentially want to script the action.
        //
        // However, iOS strictly forbids sending SMS without UI confirmation per message for security.
        // The only "loophole" is Shortcuts "Send Message" action which still requires confirmation
        // unless "Show When Run" is off, but that's for the System Shortcut, not custom App Intent.
        //
        // For this V1 implementation, "Send All" via Intent will define the data
        // and likely rely on the user running a specific Shortcut or we iterate internally
        // assuming we are foregrounded.
        
        // Since we are inside the app, the "Zap Mode" button will just trigger the foreground iterator.
        // The Intent here acts as a structure for future Siri integration.
        
        return .result()
    }
}
