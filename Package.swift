// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayUIndia-3DS2-SDK",
    platforms: [.iOS(
        .v15
    )],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PayUIndia-3DS2-SDK",
            targets: ["PayUIndia-3DS2-SDKTarget"]
        ),
        .library(
            name: "PayUIndia-Flashpay-SDK",
            targets: ["PayUIndia-Flashpay-SDKTarget"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            name: "PayUIndia-CrashReporter",
            url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS",
            from: "4.0.3"
        ),
        .package(
            name: "PayUIndia-NetworkReachability",
            url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS",
            from: "2.1.1"
        ),
        .package(
            name: "PayUIndia-Analytics",
            url: "https://github.com/payu-intrepos/PayUAnalytics-iOS.git",
            from: "4.0.2"
        ),
    ],
    targets: [
        .target(
            name: "PayUIndia-3DS2-SDKTarget",
            dependencies: [
                "PayUTridentityMFAKit",
                "PayU3DS2CoreKit",
                "PayU3DS2Kit",
                "PayUliboqs",
                .product(
                    name: "PayUIndia-CrashReporter",
                    package: "PayUIndia-CrashReporter"
                ),
                .product(
                    name: "PayUIndia-NetworkReachability",
                    package: "PayUIndia-NetworkReachability"
                ),
                .product(
                    name: "PayUIndia-Analytics",
                    package: "PayUIndia-Analytics"
                )
            ],
            path: "PayUIndia-3DS2-SDKWrapper"
        ),
        .target(
            name: "PayUIndia-Flashpay-SDKTarget",
            dependencies: [
                "PayUTridentityMFAKit",
                "PayUFlashPayKit",
                "PayUliboqs",
                "PayUFlashPayAnalytics",
                .product(
                    name: "PayUIndia-CrashReporter",
                    package: "PayUIndia-CrashReporter"
                ),
                .product(
                    name: "PayUIndia-NetworkReachability",
                    package: "PayUIndia-NetworkReachability"
                )
            ],
            path: "PayUIndia-Flashpay-SDKWrapper"
        ),
        .binaryTarget(
            name: "PayUTridentityMFAKit",
            path: "./PayUTridentityMFAKit.xcframework"
        ),
        .binaryTarget(
            name: "PayU3DS2CoreKit",
            path: "./PayU3DS2CoreKit.xcframework"
        ),
        .binaryTarget(
            name: "PayU3DS2Kit",
            path: "./PayU3DS2Kit.xcframework"
        ),
        .binaryTarget(
            name: "PayUFlashPayKit",
            path: "./PayUFlashPayKit.xcframework"
        ),
        .binaryTarget(
            name: "PayUliboqs",
            path: "./PayUliboqs.xcframework"
        ),
        .binaryTarget(
            name: "PayUFlashPayAnalytics",
            path: "./analytics/PayUAnalyticsKitU.xcframework"
        )
    ]
)
