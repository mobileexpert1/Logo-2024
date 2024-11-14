# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Logo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Logo

  target 'LogoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LogoUITests' do
    # Pods for testing
  end
 pod 'Alamofire', '~> 5.5'
 pod 'SwiftyJSON', '~> 5.0'
 pod 'SimplePDF'
 pod 'IQKeyboardManagerSwift'
 pod 'Firebase/Auth'
 pod 'Firebase/Analytics'
 pod 'Firebase/Messaging'
 pod 'YYCalendar'
 pod 'PKHUD', '~> 5.0'
 pod 'SDWebImage'
# pod 'Charts'
 pod 'MultipleLineChartView'
 pod 'DropDown'
 pod 'Charts'
 pod 'iOSDropDown'
 pod 'FSCalendar'
 pod 'MSCircularSlider'
 pod ‘SideMenu’
 pod 'SevenSwitch', '~> 2.1'
 pod "SwiftSignatureView"
 pod 'Lightbox'
end
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.5'
 
  end
 end
end
