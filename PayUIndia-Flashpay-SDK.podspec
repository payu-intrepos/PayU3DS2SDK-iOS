Pod::Spec.new do |s|
  s.name                = "PayUIndia-Flashpay-SDK"
  s.version             = '1.0.2'
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/PayU3DS2SDK-iOS"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "Flashpay SDK for iOS by PayU"
  s.description         = "Flashpay iOS SDK provides 3D Secure payment flow and Biometric Payments."

  s.source              = { :git => "https://github.com/payu-intrepos/PayU3DS2SDK-iOS.git",
                            :tag => "#{s.name}#{s.version}"
                          }
  s.documentation_url   = "https://devguide.payu.in/mobile-sdk-ios/introduction-to-payu-mobile-sdk/"
  s.platform            = :ios , "15.0"
  s.vendored_frameworks = 'PayUFlashPayKit.xcframework'
  s.dependency            'PayUIndia-TridentityMFA-SDK', '~> 3.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 2.1'
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-Analytics', '~> 4.0'
end
