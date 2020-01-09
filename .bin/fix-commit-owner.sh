#!/bin/sh

read -p "Old email: " old_email
read -p "Correct user name (Your real name, not the github username): " username
read -p "Correct email: " correct_email

read -p "Are you sure? (y, n) " letPass

if [ -n $letPass ]; then
  if [ "$letPass" == "n" ]; then
    exit
  fi
fi

git filter-branch --env-filter '

OLD_EMAIL=$old_email
CORRECT_NAME=$username
CORRECT_EMAIL=$correct_email

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags