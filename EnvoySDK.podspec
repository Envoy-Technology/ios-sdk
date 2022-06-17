Pod::Spec.new do |spec|
  spec.name                  = "EnvoySDK"
  spec.version               = "0.0.1"
  spec.summary               = "EnvoySDK for iOS"
  spec.homepage              = "https://dev-platform.envoy.is"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "Envoy IT Delivery" => "vk@develux.com" }
  spec.source                = { :git => "https://github.com/Envoy-Technology/ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files          = "Classes", "EnvoySDK/**/*.{h,m,swift}"
  spec.exclude_files         = "Classes/Exclude"
  spec.platform              = :ios
  spec.swift_version         = "5.0"
  spec.ios.deployment_target = "13.0"
  spec.dependency              "Mixpanel-swift"
end
