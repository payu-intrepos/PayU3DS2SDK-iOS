Pod::Spec.new do |s|
  s.name                = "PayUIndia-TridentityMFA-SDK"
  s.version             = "1.0.0-alpha.1"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayU3DS2SDK-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "3DS SDK for iOS by PayUbiz"
  s.description         = "3DS iOS SDK provides 3D Secure payment flow."

  s.source              = { :git => "https://github.com/payu-intrepos/PayU3DS2SDK-iOS.git",
                            :tag => "#{s.name}#{s.version}"
                          }
  s.documentation_url   = "https://devguide.payu.in/mobile-sdk-ios/introduction-to-payu-mobile-sdk/"
  s.platform            = :ios , "13.0"
  s.vendored_frameworks = 'PayUTridentityMFAKit.xcframework'
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-Analytics', '~> 4.0'
end
