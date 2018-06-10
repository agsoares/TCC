#! /usr/bin/env sh

if [ ! -f .env ]
then
  export $(cat .env | xargs)
fi

openssl enc -aes-256-cbc -in Sources/Application/GoogleService-Info.plist -out Sources/Application/GoogleService-Info.plist.enc -k $PASSWORD_ENCRYPT