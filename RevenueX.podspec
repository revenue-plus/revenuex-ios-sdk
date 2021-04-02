Pod::Spec.new do |s|
  s.name             = "RevenueX"
  s.version          = "0.26.0-copy"
  s.summary          = "Subscription and purchase tracking system"

  s.description      = <<-DESC
                       Secure, reliable, and free to use in-app purchase server. Build and manage your app business without having to maintain purchase infrastructure.
                       DESC

  s.homepage         = "https://github.com/revenue-plus/revenuex-ios-sdk.git"
  s.license          =  { :type => 'MIT' }
  s.author           = { "Mobilex, Inc." => "support@mobilex.com.tr" }
  s.source           = { :git => "https://github.com/revenue-plus/revenuex-ios-sdk.git", :tag => s.version.to_s }
  s.documentation_url = "https://sdk.revenueplus.net/api-docs"

  s.framework      = 'StoreKit'
  s.swift_version       = '5.0'
  s.ios.deployment_target = '9.0'

  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  s.source_files = 'RevenueX/**/*.{swift}'

end
