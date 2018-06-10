#!/usr/bin/env sh

if [ ! -f .env ]
then
  export $(cat .env | xargs)
fi

openssl enc -aes-256-cbc -d -in Sources/Application/GoogleService-Info.plist.enc -out Sources/Application/GoogleService-Info.plist -k $PASSWORD_ENCRYPT