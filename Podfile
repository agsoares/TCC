platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

target 'TCC' do
  pod 'ObjectMapper'
  pod 'SnapKit'

  pod 'RxSwift'
  pod 'RxSwiftExt'
  pod 'RxCocoa'
  pod 'RxDataSources'
  
  pod 'Firebase/Core',  '~> 5.0'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'

  pod 'SwiftGen'
  pod 'Sourcery'
  pod 'SwiftLint'
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = 's'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-O'
        if config.name == 'Release'
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
        end
    end
end
