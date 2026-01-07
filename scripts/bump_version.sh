#!/bin/bash

# Simple script to bump build number and optionally version
# Usage: ./bump_version.sh [minor|major|patch] (defaults to just incrementing build number)

PROJECT_FILE="sendAll.xcodeproj/project.pbxproj"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Error: $PROJECT_FILE not found. Run this from the root of the project."
    exit 1
fi

# Function to get current value
get_current() {
    grep "$1 =" "$PROJECT_FILE" | head -n 1 | sed -E 's/.*= (.*);/\1/'
}

CURRENT_VERSION=$(get_current "MARKETING_VERSION")
CURRENT_BUILD=$(get_current "CURRENT_PROJECT_VERSION")

echo "Current Version: $CURRENT_VERSION"
echo "Current Build: $CURRENT_BUILD"

NEW_BUILD=$((CURRENT_BUILD + 1))

# Simple sed to replace inplace. check for macos (-i '')
sed -i '' "s/CURRENT_PROJECT_VERSION = $CURRENT_BUILD;/CURRENT_PROJECT_VERSION = $NEW_BUILD;/g" "$PROJECT_FILE"

echo "Bumped Build to: $NEW_BUILD"

# Optional: logic to bump version string (very basic implementation)
# You can expand this to handle semantic versioning arguments
# For now, it just bumps the build number which is sufficient for uploads.
