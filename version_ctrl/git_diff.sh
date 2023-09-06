#!/bin/bash
# Run this script to check differences between two commits, only files already existing in the start commit are included
# Usage:
# ```bash
# bash git_diff.sh $start_commit_hash $end_commit_hash
# ```
# Variables
START_COMMIT="$1"
END_COMMIT="$2"

# Create a temporary file to store the changes
TMP_FILE=$(mktemp)

# Get the list of files changed between the two commits
FILES_CHANGED=$(git diff --name-only "$START_COMMIT".."$END_COMMIT")

# Loop through each file and compare its changes
for FILE in $FILES_CHANGED; do
    # Check if the file exists in the start commit
    if git show "$START_COMMIT":"$FILE" >/dev/null 2>&1; then
        echo "Comparing changes for file: $FILE" >> "$TMP_FILE"
        echo "--------------------------------------" >> "$TMP_FILE"
        git diff "$START_COMMIT".."$END_COMMIT" -- "$FILE" >> "$TMP_FILE"
        echo "--------------------------------------" >> "$TMP_FILE"
    fi
done

# Open the temporary file with the default text viewer
cat "$TMP_FILE"  # Replace with your platform's command to open files

# Clean up the temporary file
rm "$TMP_FILE"
