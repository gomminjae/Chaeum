# Uncomment the next line to define a global platform for your project
# platform :ios, '16.5'

target 'Chaeum' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'RxSwift' 
  pod 'RxCocoa'
  pod 'RxKeyboard'
  pod 'RxDataSources'
  pod 'SnapKit' 
  pod 'Alamofire'
  pod 'Then'
  pod 'lottie-ios'
  pod 'RealmSwift'
  pod 'ReactorKit'
  pod 'FSCalendar'
  pod 'TextFieldEffects'
  # Pods for Chaeum

  target 'ChaeumTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ChaeumUITests' do
    # Pods for testing
  end

end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.5'
      end
    end
  end
end
