#!/bin/bash

# Function to check the status of the repository and display a message
check_status() {
  status=$(git status | grep "nothing to commit, working tree clean")
  if [ -n "$status" ]; then
    echo "Working tree is clean, nothing to add or commit."
  else
    echo "Adding all changes to the Git index."
    git add *
    
    # Ask for commit message
    read -p "Enter commit message: " commit_message

    # Commit changes with commit message
    echo "Committing changes with the message: $commit_message"
    git commit -m "$commit_message"
    
    ahead_status=$(git status | grep "Your branch is ahead of 'origin/main' by")
    if [ -n "$ahead_status" ]; then
      echo "$ahead_status"
      echo "Pushing changes to the remote repository."
      git push
    else
      echo "Nothing to push."
    fi
  fi
}

# Call the function to check the repository status
check_status
