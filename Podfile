platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

target 'TCC' do
  pod 'ObjectMapper',   '~> 3.3'

  pod 'RxSwift',        '~> 4.0'
  pod 'RxCocoa',        '~> 4.0'
  pod 'RxDataSources'

  pod 'Firebase/Core',  '~> 5.0'
  pod 'Firebase/Auth',  '~> 5.0'
  pod 'Firebase/Firestore'

  pod 'SwiftGen'
  pod 'Sourcery'
  pod 'SwiftLint'
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        if config.name == 'Release'
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
        end
    end
end
