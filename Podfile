platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

target 'TCC' do
  pod 'ObjectMapper',   '~> 3.0'
  pod 'SnapKit',        '~> 4.0'

  pod 'RxSwift',        '~> 4.0'
  pod 'RxSwiftExt',     :git => 'https://github.com/RxSwiftCommunity/RxSwiftExt.git', :branch => 'master'
  pod 'RxCocoa',        '~> 4.0'
  pod 'RxDataSources',  '~> 3.0'

  pod 'Action',         '~> 3.0'
  
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
