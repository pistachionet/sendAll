# Release Guide

This guide explains how to package and release a new version of `sendAll`.

## Prerequisites

- Xcode installed
- Apple Developer Account with appropriate permissions

## Steps to Release

1.  **Update Version (if not already done)**

    - Open `sendAll.xcodeproj`.
    - Select the project in the Project Navigator (blue icon).
    - Under "General" > "Identity", update "Version" and "Build".
    - _Alternatively, run `scripts/bump_version.sh`._

2.  **Archive the App**

    - Select "Any iOS Device (arm64)" as the destination from the scheme selector (top bar).
    - Go to **Product** > **Archive**.
    - Wait for the build to complete. The Organizer window should open automatically.

3.  **Validate and Upload**

    - In the Organizer, select the latest archive.
    - Click **Distribute App**.
    - Select **TestFlight & App Store** (or "Ad Hoc" for local distribution).
    - Follow the prompts (usually keeping default settings for App Store Connect distribution).
    - Click **Upload**.

4.  **App Store Connect**
    - Once uploaded, go to [App Store Connect](https://appstoreconnect.apple.com).
    - Navigate to **"My Apps"** > **"sendAll"**.
    - Select the new version (or create it if it doesn't exist).
    - In the **"What's New in This Version"** text box, paste your patch notes (you can draft them in `CHANGELOG.md`).
    - Select the build you just uploaded.
    - Submit for Review.

## Troubleshooting

- **Signing Issues**: Ensure you are logged into your Apple ID in Xcode > Settings > Accounts.
- **Build Failures**: Check the Issue Navigator (Cmd+5) for errors.
