Pod::Spec.new do |s|
  s.name                = "PayUIndia-3DS2-SDK"
  s.version             = "1.0.0-alpha"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayU3DS2SDK-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "3DS SDK for iOS by PayUbiz"
  s.description         = "3DS iOS SDK provides 3D Secure payment flow."

  s.source              = { :git => "https://github.com/payu-intrepos/PayU3DS2SDK-iOS.git",
                            :tag => "#{s.version}"
                          }
  s.documentation_url   = "https://devguide.payu.in/mobile-sdk-ios/introduction-to-payu-mobile-sdk/"
  s.platform            = :ios , "11.0"
  s.vendored_frameworks = 'PayU3DS2Kit.xcframework'

  s.dependency            'PayUIndia-3DS2Core-SDK', '~> 1.0.0-alpha'
  s.dependency            'PayUIndia-NetworkReachability', '~> 1.0'
  s.dependency            'PayUIndia-CrashReporter', '~> 2.1'

end
