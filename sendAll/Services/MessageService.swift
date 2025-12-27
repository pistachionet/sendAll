import Foundation
import MessageUI
import SwiftUI

class MessageService: NSObject, MFMessageComposeViewControllerDelegate {
    var onCompletion: ((MessageComposeResult) -> Void)?
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true) {
            self.onCompletion?(result)
        }
    }
}

struct MessageComposerView: UIViewControllerRepresentable {
    let recipients: [String]
    let body: String
    let completion: (MessageComposeResult) -> Void
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.recipients = recipients
        controller.body = body
        controller.messageComposeDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        // Don't update - body and recipients are set once in makeUIViewController
    }
    
    func makeCoordinator() -> MessageService {
        let coordinator = MessageService()
        coordinator.onCompletion = completion
        return coordinator
    }
}
