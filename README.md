# sendAll

**send mass texts individually**

![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2017.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-blue.svg)

**sendAll** is a native iOS application sendAll allows you to send mass texts *individually*.

*Unfortunately* Apple blocks any applications from altering messages behavior at an OS level so there is no way to send mass texts at once. 
<p align="center">
  <img src="https://github.com/user-attachments/assets/76afea44-4967-465e-b980-6ef40fd38b1a" width="220" />
  <img src="https://github.com/user-attachments/assets/ba18b13a-0320-41ec-8862-a51664547a8b" width="220" />
  <img src="https://github.com/user-attachments/assets/53ced0f7-ca7e-4860-bc89-b8e397ab9288" width="220" />
</p>

## ✨ Features

- **Individual Messaging**: Review and send messages to each recipient individually. No group chats.
- **Review Flow**:
  - **Editable Cards**: Customize the message for specific people on the fly.
  - **Navigation**: Skip contacts or go back to correct a mistake before sending.
  - **Progress Tracking**: See exactly how many messages are sent vs. skipped.
- **Contact Management**:
  - Select multiple contacts from your address book.
  - Add numbers manually with ease.
  - Floating "Done" button for quick selection.
- **Privacy First**:
  - **No Backend**: All data stays on your device.
  - **Direct Sending**: Uses your device's native Message app (iMessage/SMS).
- **Liquid Design**: A beautiful, fluid interface with glassmorphism effects, gradients, and smooth animations.

## 🛠 Tech Stack

- **Language**: Swift 5
- **UI Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **System Frameworks**:
  - `MessageUI`: For native message composition.
  - `Contacts`: For secure address book access.
  - `UIKit`: For haptic feedback and view controller integrations.

## 📸 Usage

1. **Add Recipients**: Choose from your contacts or enter numbers manually.
2. **Compose**: Draft your core message.
3. **Review**: Swipe through your recipients.
   - Tap the message to **edit** it for that specific person.
   - Tap **Skip** if you changed your mind for one person.
   - Tap **Send** to launch the native message sheet.
4. **Done**: Get a summary of how many messages were sent.

## 📄 License

This project is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)** license.

You are free to:

- **Share** — copy and redistribute the material in any medium or format.
- **Adapt** — remix, transform, and build upon the material.

Under the following terms:

- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
- **NonCommercial** — You may not use the material for commercial purposes.
- **ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

See the [LICENSE](LICENSE) file for the full text.
