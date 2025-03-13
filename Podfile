# Uncomment the next line to define a global platform for your project
platform :ios, '15.6'

target 'TestMeliApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TestMeliApp
  
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'MBProgressHUD'

  target 'TestMeliAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TestMeliAppUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end

end
