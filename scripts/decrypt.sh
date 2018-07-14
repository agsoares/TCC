#!/usr/bin/env sh

[ -a .env ] && export $(cat .env | xargs)

openssl enc -aes-256-cbc -d -in Sources/Application/GoogleService-Info.plist.enc -out Sources/Application/GoogleService-Info.plist -k $PASSWORD_ENCRYPT