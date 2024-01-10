// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayUIndia-3DS2-SDK",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PayUIndia-3DS2-SDK",
            targets: ["PayUIndia-3DS2-SDKTarget"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "PayUIndia-CrashReporter",url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS",from: "3.0.0"),
        .package(name: "PayUIndia-NetworkReachability", url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS", from: "2.0.1")
    ],
    targets: [
        
        .target(
            name: "PayUIndia-3DS2-SDKTarget",
            dependencies: [
                "PayU3DS2CoreKit",
		"PayU3DS2Kit",
                .product(name: "PayUIndia-CrashReporter", package: "PayUIndia-CrashReporter"),
                .product(name: "PayUIndia-NetworkReachability", package: "PayUIndia-NetworkReachability")
            ],
            path: "PayUIndia-3DS2-SDKWrapper"
        ),
        
            .binaryTarget(name: "PayU3DS2CoreKit", path: "./PayU3DS2CoreKit.xcframework"),
            .binaryTarget(name: "PayU3DS2Kit", path: "./PayU3DS2Kit.xcframework")
    ]
)
