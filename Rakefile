require 'dotenv/tasks'

task default: %w[decrypt]

files = [
    "Sources/Application/GoogleService-Info.plist"
]

task encrypt: :dotenv do
    password = ENV['PASSWORD_ENCRYPT']
    for file in files do
        system("openssl enc aes-256-cbc -d -a -in #{file} -out #{file}.enc -k #{password}")
    end
end

task decrypt: :dotenv do
    password = ENV['PASSWORD_ENCRYPT']
    for file in files do
        system("openssl enc -aes-256-cbc -d -in #{file}.enc -out #{file} -k #{password}")
    end
end