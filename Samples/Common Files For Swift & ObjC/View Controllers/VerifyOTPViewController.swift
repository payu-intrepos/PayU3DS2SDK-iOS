//
//  VerifyOTPViewController.swift
//  PayU3DS2SwiftSample
//
//  Created by Sakshi Dubey on 12/02/24.
//

import UIKit
import PayU3DS2Kit

class VerifyOTPViewController: BaseViewController {
    
    var challengeInputParameters: PayU3DS2ACSActionParams?
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var otpSentLabel: UILabel!
    @IBOutlet var otpErrorLabel: UILabel!
    @IBOutlet var otpInfoLabel: UILabel!
    @IBOutlet var otpTextField: UITextField!
    @IBOutlet var resendButton: UIButton!
    var image1: String?
    var image2: String?
    var otpSentText: String?
    var resendButtonVisible: Bool = false
    var showAlertMessage: ((_ text: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.loadImage(with: image1 ?? "")
        imageView2.loadImage(with: image2 ?? "")
        otpSentLabel.text = otpSentText ?? ""
        otpErrorLabel.isHidden = true
        otpInfoLabel.isHidden = true
        if resendButtonVisible {
            resendButton.isHidden = false
        } else {
            resendButton.isHidden = true
        }
    }
    
    func setupView(image1: String?, image2: String?, otpSentText: String?, resendButtonVisible: Bool) {
        self.image1 = image1
        self.image2 = image2
        self.otpSentText = otpSentText ?? ""
        self.resendButtonVisible = resendButtonVisible
    }
    
    // MARK: - IBActions -

    @IBAction func submitOTP(_: Any) {
        DispatchQueue.main.async {
            Loader.shared.show()
        }
        if let challengeInputParameters = challengeInputParameters,
           let otp = otpTextField.text {
            PayU3DS2SDKHelper.action(with: .submit,
                                     challengeInputParams: PayU3DS2ACSActionParams.init(challengeData: otp,
                                                                                        acsRenderingType: challengeInputParameters.acsRenderingType,
                                                                                        acsTransactionID: challengeInputParameters.acsTransactionID)) { [weak self] response in
                DispatchQueue.main.async {
                    Loader.shared.hide()
                    let response: PayU3DS2Response? = response
                    if let response = response?.result as? PayU3DS2ACSResponse {
                    self?.showAlertMessage?(response.message)
                    self?.dismiss(animated: true)
                } else if let error = response?.errorMessage {
                        self?.otpErrorLabel.isHidden = false
                        self?.otpErrorLabel.text = error
                }
                }
            }
        }
    }

    @IBAction func resendOTP(_: Any) {
        DispatchQueue.main.async {
            Loader.shared.show()
        }
        if let challengeInputParameters = challengeInputParameters {
            PayU3DS2SDKHelper.action(with: .resend,
                                     challengeInputParams: challengeInputParameters) { [weak self] response in
                DispatchQueue.main.async {
                    Loader.shared.hide()
                    let response: PayU3DS2Response? = response
                    if let response = response?.result as? PayU3DS2ACSResponse {
                            self?.otpInfoLabel.isHidden = false
                            self?.otpInfoLabel.text = response.message
                    } else if let error = response?.errorMessage {
                        self?.otpErrorLabel.isHidden = false
                        self?.otpErrorLabel.text = error
                }
                }
            }
        }
    }
    
    @IBAction func cancel(_: Any) {
        DispatchQueue.main.async {
            Loader.shared.show()
        }
        if let challengeInputParameters = challengeInputParameters {
            PayU3DS2SDKHelper.action(with: .cancel,
                                     challengeInputParams: challengeInputParameters) { response in
                DispatchQueue.main.async {
                    Loader.shared.hide()
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
}
