//
//  Loader.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import Foundation
import UIKit

class Loader: UIView {
    static let shared: Loader = {
        let instance = Loader()
        return instance
    }()

    private let loader = UIActivityIndicatorView()

    override private init(frame: CGRect) {
        super.init(frame: frame)
        prepared()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepared() {
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        frame = UIScreen.main.bounds
        loader.frame = UIScreen.main.bounds
        loader.style = .whiteLarge
        loader.center = center
        loader.color = .gray
        addSubview(loader)
    }

    func show() {
        let application = UIApplication.shared.delegate as! AppDelegate
        application.window?.addSubview(self)

        loader.startAnimating()
        loader.bringSubviewToFront((application.window?.rootViewController?.view)!)
    }

    func hide() {
        removeFromSuperview()
        loader.stopAnimating()
    }
}
