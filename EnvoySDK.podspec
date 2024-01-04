Pod::Spec.new do |spec|
  spec.name                  = "EnvoySDK"
  spec.version               = "0.0.1"
  spec.summary               = "EnvoySDK for iOS"
  spec.homepage              = "https://dev-platform.envoy.is"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "Envoy IT Delivery" => "vk@develux.com" }
  spec.source                = { :git => "https://github.com/Envoy-Technology/ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files          = "Classes", "EnvoySDK/**/*.{h,m,swift}", "Extensions"
  spec.resource_bundles      = {
    spec.name => 'EnvoySDK/**/*.{xcassets,xib}'
  }
  spec.platform              = :ios
  spec.swift_version         = "5.0"
  spec.ios.deployment_target = "15.0"

  # spec.dependency "Wormholy"

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'EnvoySDKTests/**/*.{swift}'
  end
end
