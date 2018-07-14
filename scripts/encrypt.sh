#! /usr/bin/env sh

[ -a .env ] && export $(cat .env | xargs)

openssl enc -aes-256-cbc -in Sources/Application/GoogleService-Info.plist -out Sources/Application/GoogleService-Info.plist.enc -k $PASSWORD_ENCRYPT