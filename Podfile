# Uncomment the next line to define a global platform for your project
# platform :ios, '16.5'

target 'Chaeum' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  #RxSwift
  pod 'RxSwift' 
  pod 'RxCocoa'
  pod 'RxKeyboard'
  pod 'RxDataSources'

  #Layout 
  pod 'SnapKit'

  #Networking
  pod 'Alamofire'

  #Storage
  pod 'RealmSwift'
  pod 'RxRealm'
  #Archi
  pod 'ReactorKit'

  #ETC 
  pod 'Then'
  pod 'lottie-ios'
  pod 'FSCalendar'
  pod 'TextFieldEffects'
  
  #DI
  pod 'Swinject' 
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
