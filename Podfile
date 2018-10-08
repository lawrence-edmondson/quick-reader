project 'quick-read.xcodeproj'

# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# ignore all warnings from all pods
inhibit_all_warnings!


target 'quick-read' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for notorious
    pod 'AFNetworking'    
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'Material'
    pod 'Motion'
    pod 'Graph'  
    pod 'IGListKit', '~> 3.0'
end

	post_install do |installer|
	  installer.pods_project.targets.each do |target|
	    target.build_configurations.each do |config|
	      config.build_settings['SWIFT_VERSION'] = '4.0'
	      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'Yes'
	    end
	  end
	end	

