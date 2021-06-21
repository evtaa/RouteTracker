# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RouteTracker' do
  # Comment the next line if you don't want to use dynamic frameworks

  #post_install do |installer|
  #    installer.pods_project.build_configurations.each do |config|
  #    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  #  end
  #end

  use_frameworks!

  # Pods for RouteTracker

  target 'RouteTrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RouteTrackerUITests' do
    # Pods for testing
  end

  pod 'GoogleMaps', '5.0.0'
  pod 'RealmSwift', '10.1.4'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
end
