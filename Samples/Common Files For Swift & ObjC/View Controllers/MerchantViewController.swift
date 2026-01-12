//
//  MerchantViewController.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2Kit
import UIKit

class MerchantViewController: BaseViewController {
    // MARK: - Variables -

    let keySalt = [["<key>", "<sat>"]]

    let indexKeySalt = 0
    var amount: String = "1"
    var email: String = "amit.salaria@payu.in"
    var userCredential: String = "amit:salaria"

    // MARK: - IBOutlets -

    @IBOutlet weak var firstOTPInfo: UITextField!
    @IBOutlet weak var resendBtnTF: UITextField!
    @IBOutlet weak var submitBtnTF: UITextField!
    @IBOutlet weak var merchantNameTf: UITextField!
    @IBOutlet weak var txnTimoutSwitch: UISwitch!
    @IBOutlet weak var newCustomizedUISwitch: UISwitch!
    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var saltTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var userCredentialTextField: UITextField!
    @IBOutlet var supportedUITextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    // Buttons
    @IBOutlet var buttonBackgroundColorTextFields: [UITextField]!
    @IBOutlet var buttonCornerRadiusTextFields: [UITextField]!
    @IBOutlet var buttonFontColorTextFields: [UITextField]!
    @IBOutlet var buttonFontSizeTextFields: [UITextField]!
    @IBOutlet var buttonFontNameTextFields: [UITextField]!
    @IBOutlet var resendFontColorTextField: UITextField!
    @IBOutlet var textCaseTypeTextField: UITextField!
    
    @IBOutlet var primaryButtonEnableFontColorTextFields: UITextField!
    @IBOutlet var primaryButtonDisableFontColorTextFields: UITextField!
    @IBOutlet var primaryButtonEnableBackgroundColorTextFields: UITextField!
    @IBOutlet var primaryButtonDisableBackgroundColorTextFields: UITextField!

    @IBOutlet var secondaryButtonEnableFontColorTextFields: UITextField!
    @IBOutlet var secondaryButtonDisableFontColorTextFields: UITextField!
    @IBOutlet var secondaryButtonEnableBackgroundColorTextFields: UITextField!
    @IBOutlet var secondaryButtonDisableBackgroundColorTextFields: UITextField!

    // Label
    @IBOutlet var labelHeaderFontColorTextField: UITextField!
    @IBOutlet var labelHeaderFontSizeTextField: UITextField!
    @IBOutlet var labelHeaderFontNameTextField: UITextField!
    @IBOutlet var labelHeaderBackgroundColorTextField: UITextField!
    @IBOutlet var labelFontSizeTextField: UITextField!
    @IBOutlet var labelFontColorTextField: UITextField!
    @IBOutlet var labelFontNameTextField: UITextField!
    @IBOutlet var labelBackgroundColorTextField: UITextField!
    // Textbox
    @IBOutlet var textboxBorderColorTextField: UITextField!
    @IBOutlet var textboxBorderWidthTextField: UITextField!
    @IBOutlet var textboxCornerRadiusTextField: UITextField!
    @IBOutlet var textboxFontColorTextField: UITextField!
    @IBOutlet var textboxFontSizeTextField: UITextField!
    @IBOutlet var textboxFontNameTextField: UITextField!
    // Toolbar
    @IBOutlet var toolbarBackgroundColorTextField: UITextField!
    @IBOutlet var toolbarButtonTextTextField: UITextField!
    @IBOutlet var toolbarHeaderTextTextField: UITextField!
    @IBOutlet var toolbarFontColorTextField: UITextField!
    @IBOutlet var toolbarFontSizeTextField: UITextField!
    @IBOutlet var toolbarFontNameTextField: UITextField!
    // Font Family
    @IBOutlet var headerFontNameTextField: UITextField!
    @IBOutlet var subtextFontNameTextField: UITextField!
    // Text
    @IBOutlet var topHeaderText: UITextView!
    @IBOutlet var topSubHeaderText: UITextView!
    @IBOutlet var headerTextForContents: UITextView!
    @IBOutlet var subTextForContents: UITextView!
    @IBOutlet var numberVerificationProcessingText: UITextView!
    @IBOutlet var numberVerifiedText: UITextView!
    @IBOutlet var biometricSetupText: UITextView!
    @IBOutlet var biometricVerifiedText: UITextView!
    // Success Text
    @IBOutlet var successTopHeaderText: UITextView!
    @IBOutlet var successTopSubHeaderText: UITextView!
    @IBOutlet var successHeaderTextForContents: UITextView!
    @IBOutlet var successSubTextForContents: UITextView!
    @IBOutlet var successButtonText: UITextView!
    // Failure Text
    @IBOutlet var failureTopHeaderText: UITextView!
    @IBOutlet var failureTopSubHeaderText: UITextView!
    @IBOutlet var failureHeaderTextForContents: UITextView!
    @IBOutlet var failureSubTextForContents: UITextView!
    @IBOutlet var failureButtonText: UITextView!

    // Config
    @IBOutlet var isProductionSwitch: UISwitch!
    @IBOutlet var fallback3DS1Switch: UISwitch!
    @IBOutlet var authenticateOnlySwitch: UISwitch!
    @IBOutlet var autoSubmitSwitch: UISwitch!
    @IBOutlet var isNumericKeyboardSwitch: UISwitch!
    @IBOutlet var showDefaultLoaderSwitch: UISwitch!
    @IBOutlet var defaultLoaderColorTextField: UITextField!
    @IBOutlet var merchantResponseTimeoutTextField: UITextField!
    @IBOutlet var minOtpLengthTextField: UITextField!
    @IBOutlet var resendOTPAllowCountTextField: UITextField!
    @IBOutlet var customizeUISwitch: UISwitch!
    @IBOutlet var customizeUIStackView: UIStackView!
    @IBOutlet weak var maxResendOTPInfoTF: UITextField!
    @IBOutlet weak var resendOTPInfoTF: UITextField!
    
    // MARK: - Class Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpValuesInTextFields()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let vc = segue.destination as? CardDetailsViewController else { return }
        vc.key = keyTextField.text ?? ""
        vc.salt = saltTextField.text ?? ""
        vc.amount = amountTextField.text ?? ""
        vc.email = emailTextField.text ?? ""
        vc.userCredential = userCredentialTextField.text ?? ""
        vc.config = getSDKConfig()
    }

    // MARK: - IBActions -

    @IBAction func customiseUISwitchAction(_: Any) {
        customizeUIStackView.isHidden = !customizeUISwitch.isOn
    }

    @IBAction func nextButtonAction(_: Any) {
        view.endEditing(true)
        performSegue(withIdentifier: kCardDetailsViewController, sender: nil)
    }
}

// MARK: - Private Methods -

extension MerchantViewController {
    private func setUpValuesInTextFields() {
        keyTextField.text = keySalt[indexKeySalt][0]
        saltTextField.text = keySalt[indexKeySalt][1]
        amountTextField.text = amount
        emailTextField.text = email
        userCredentialTextField.text = userCredential
        submitBtnTF.text = "SUBMIT"
        resendBtnTF.text = "RESEND OTP"
        merchantNameTf.text = "Swiggy"
        firstOTPInfo.text = "Successfully sent OTP to your registered mobile number"
        isProductionSwitch.isOn = false
    }

    private func updateNextButtonVisibility() {
        let isEnable = ((keyTextField.text?.isEmpty == false) && (saltTextField.text?.isEmpty == false) && (amountTextField.text?.isEmpty == false) && (emailTextField.text?.isEmpty == false))
        nextButton.isUserInteractionEnabled = isEnable
        nextButton.backgroundColor = nextButton.backgroundColor?.withAlphaComponent(isEnable ? 1 : 0.5)
    }

    private func getUICustomisation() -> PayU3DS2UICustomisation {
        PayU3DS2UICustomisation(
            buttonCustomisation: getButtonCustomisation(),
            labelCustomisation: getLabelCustomisation(),
            textBoxCustomisation: getTextboxCustomisation(),
            toolbarCustomisation: getToolbarCustomisation(),
            fontFamilyCustomisation: getFontFamilyCustomisation(),
            textCustomisation: getTextCustomisation()
        )
    }

    private func getButtonCustomisation() -> PayU3DS2ButtonCustomisation {
        PayU3DS2ButtonCustomisation(
            textFontColor: buttonFontColorTextFields[2].text,
            textFontSize: Int(buttonFontSizeTextFields[2].text ?? "") ?? 15,
            backgroundColor: buttonBackgroundColorTextFields[2].text,
            cornerRadius: Int(buttonCornerRadiusTextFields[2].text ?? "") ?? 5,
            resendButtonTextFontColor: resendFontColorTextField.text,
            textCaseType: getTextCaseType()
        )
    }

    private func getTextCaseType() -> PayU3DS2ButtonTextCaseType {
        switch textCaseTypeTextField.text {
        case "lowercase": return .lowercase
        case "uppercase": return .uppercase
        default: return .default
        }
    }

    private func getLabelCustomisation() -> PayU3DS2LabelCustomisation {
        PayU3DS2LabelCustomisation(
            textFontColor: labelFontColorTextField.text,
            textFontSize: Int(labelFontSizeTextField.text ?? "") ?? 15,
            backgroundColor: labelBackgroundColorTextField.text,
            headingTextColor: labelHeaderFontColorTextField.text,
            headingTextFontSize: Int(labelHeaderFontSizeTextField.text ?? "") ?? 15,
            headingBackgroundColor: labelHeaderBackgroundColorTextField.text
        )
    }

    private func getTextboxCustomisation() -> PayU3DS2TextBoxCustomisation {
        PayU3DS2TextBoxCustomisation(
            textFontColor: textboxFontColorTextField.text,
            textFontSize: Int(textboxFontSizeTextField.text ?? "") ?? 15,
            borderColor: textboxBorderColorTextField.text,
            borderWidth: Int(textboxBorderWidthTextField.text ?? "") ?? 1,
            cornerRadius: Int(textboxCornerRadiusTextField.text ?? "") ?? 5
        )
    }

    private func getToolbarCustomisation() -> PayU3DS2ToolBarCustomisation {
        PayU3DS2ToolBarCustomisation(
            textFontColor: toolbarFontColorTextField.text,
            textFontSize: Int(toolbarFontSizeTextField.text ?? "") ?? 15,
            backgroundColor: toolbarBackgroundColorTextField.text,
            buttonText: toolbarButtonTextTextField.text,
            headerText: toolbarHeaderTextTextField.text
        )
    }

    private func getFontFamilyCustomisation() -> PayU3DS2FontFamilyCustomisation {
        PayU3DS2FontFamilyCustomisation(
            headerFontFamily: headerFontNameTextField.text,
            subTextFontFamily: subtextFontNameTextField.text
        )
    }

    private func getTextCustomisation() -> PayU3DS2TextCustomisation {
        PayU3DS2TextCustomisation(
            deviceBindingTextCustomisation: getDeviceBindingTextCustomisation(),
            deviceBindingSuccessTextCustomisation: getSuccessTextCustomisation(),
            deviceBindingFailureTextCustomisation: getFailureTextCustomisation()
        )
    }
    
    private func getDeviceBindingTextCustomisation() -> PayU3DS2DeviceBindingTextCustomisation {
        PayU3DS2DeviceBindingTextCustomisation(
            headerText: topHeaderText.text,
            subHeaderText: topSubHeaderText.text,
            numberVerificationProcessingText: numberVerificationProcessingText.text,
            numberVerifiedText: numberVerifiedText.text,
            biometricSetupText: biometricSetupText.text,
            biometricVerifiedText: biometricVerifiedText.text
        )
    }

    private func getSuccessTextCustomisation() -> PayU3DS2DeviceBindingConfirmationTextCustomisation {
        PayU3DS2DeviceBindingConfirmationTextCustomisation(
            headerText: successTopHeaderText.text,
            subHeaderText: successTopSubHeaderText.text,
            buttonText: successButtonText.text
        )
    }

    private func getFailureTextCustomisation() -> PayU3DS2DeviceBindingConfirmationTextCustomisation {
        PayU3DS2DeviceBindingConfirmationTextCustomisation(
            headerText: nil, // not in use
            subHeaderText: nil, // not in use
            buttonText: failureButtonText.text
        )
    }

    func getSDKConfig() -> PayU3DS2Config {
        let config = PayU3DS2Config()
        config.isProduction = isProductionSwitch.isOn
        config.fallback3DS1 = fallback3DS1Switch.isOn
        config.authenticateOnly = authenticateOnlySwitch.isOn
        config.autoSubmit = autoSubmitSwitch.isOn
        config.merchantResponseTimeout = TimeInterval(Int(merchantResponseTimeoutTextField.text ?? "") ?? 0) // In Seconds
        if customizeUISwitch.isOn {
            config.uiCustomisation = getUICustomisation()
        }
        config.setDefaultProgressLoader(showDefaultLoader: showDefaultLoaderSwitch.isOn, defaultProgressLoaderColor: defaultLoaderColorTextField.text ?? "")
        if let text = supportedUITextField.text,
           !text.isEmpty {
            config.supportedUIMode = text.components(separatedBy: ",")
        } else {
            config.supportedUIMode = []
        }
        config.enableCustomizedOtpUIFlow = newCustomizedUISwitch.isOn
        config.merchantName = merchantNameTf.text
        config.amount = amountTextField.text
        config.enableTxnTimeoutTimer = txnTimoutSwitch.isOn
        config.acsContentConfig = PayU3DS2ACSContentConfig()
        config.acsContentConfig?.submitButtonTitle = submitBtnTF.text
        config.acsContentConfig?.resendButtonTitle = resendBtnTF.text
        config.acsContentConfig?.otpContent = firstOTPInfo.text
        config.acsContentConfig?.resendInfoContent = resendOTPInfoTF.text
        config.acsContentConfig?.maxResendInfoContent = maxResendOTPInfoTF.text
        config.enableMFAViaBiometric = true

        return config
    }
}
