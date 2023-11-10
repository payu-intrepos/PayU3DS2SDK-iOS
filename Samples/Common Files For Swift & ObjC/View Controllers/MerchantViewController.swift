//
//  MerchantViewController.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2
import UIKit

class MerchantViewController: BaseViewController {
    // MARK: - Variables -

    let keySalt = [["2qWimx", "WbuCTeAMwq0siCKqRHHm5BHBrQwmhgOT"],
                   ["V2yqBC", "dEzD8BBD"],
                   ["0MQaQP", "7tVMWdl6"],
                   ["smsplus", "1b1b0"],
                   ["ol4Spy", "J0ZXw2z9"],
                   ["obScKz", "Ml7XBCdR"],
                   ["gtKFFx", "eCwWELxi"],
                   ["Rl8Pdr", "wsl9kqyy"],
                   ["smsplus", "350"],
                   ["IUIaFM", "67njRYSI"],
                   ["F53fW7", "PPIzLXEo"]]

    let indexKeySalt = 0
    var amount: String = "1"
    var email: String = "amit@salaria.com"
    var userCredential: String = "amit:salaria"

    // MARK: - IBOutlets -

    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var saltTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var userCredentialTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    // Buttons
    @IBOutlet var buttonBackgroundColorTextFields: [UITextField]!
    @IBOutlet var buttonCornerRadiusTextFields: [UITextField]!
    @IBOutlet var buttonFontColorTextFields: [UITextField]!
    @IBOutlet var buttonFontSizeTextFields: [UITextField]!
    @IBOutlet var buttonFontNameTextFields: [UITextField]!
    @IBOutlet var resendFontColorTextField: UITextField!
    @IBOutlet var textCaseTypeTextField: UITextField!
    // Label
    @IBOutlet var labelHeaderFontColorTextField: UITextField!
    @IBOutlet var labelHeaderFontSizeTextField: UITextField!
    @IBOutlet var labelHeaderFontNameTextField: UITextField!
    @IBOutlet var labelFontSizeTextField: UITextField!
    @IBOutlet var labelFontColorTextField: UITextField!
    @IBOutlet var labelFontNameTextField: UITextField!
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

    // MARK: - Class Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBAction func customiseUISwitchAction(_ sender: Any) {
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
            toolbarCustomisation: getToolbarCustomisation()
        )
    }

    private func getButtonCustomisation() -> PayU3DS2ButtonCustomisation {
        PayU3DS2ButtonCustomisation(
            textFontColor: buttonFontColorTextFields[2].text,
            textFontSize: Int(buttonFontSizeTextFields[2].text ?? "0") ?? 0,
            textFontFamilyName: buttonFontNameTextFields[2].text,
            backgroundColor: buttonBackgroundColorTextFields[2].text,
            cornerRadius: Int(buttonCornerRadiusTextFields[2].text ?? "0") ?? 0,
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
            textFontSize: Int(labelFontSizeTextField.text ?? "0") ?? 0,
            textFontFamilyName: labelFontNameTextField.text,
            headingTextColor: labelHeaderFontColorTextField.text,
            headingTextFontFamilyName: labelHeaderFontNameTextField.text,
            headingTextFontSize: Int(labelHeaderFontSizeTextField.text ?? "0") ?? 0
        )
    }

    private func getTextboxCustomisation() -> PayU3DS2TextBoxCustomisation {
        PayU3DS2TextBoxCustomisation(
            textFontColor: textboxFontColorTextField.text,
            textFontSize: Int(textboxFontSizeTextField.text ?? "0") ?? 0,
            textFontFamilyName: textboxFontNameTextField.text,
            borderColor: textboxBorderColorTextField.text,
            borderWidth: Int(textboxBorderWidthTextField.text ?? "0") ?? 0,
            cornerRadius: Int(textboxCornerRadiusTextField.text ?? "0") ?? 0
        )
    }

    private func getToolbarCustomisation() -> PayU3DS2ToolBarCustomisation {
        PayU3DS2ToolBarCustomisation(
            textFontColor: toolbarFontColorTextField.text,
            textFontSize: Int(toolbarFontSizeTextField.text ?? "0") ?? 0,
            textFontFamilyName: toolbarFontNameTextField.text,
            backgroundColor: toolbarBackgroundColorTextField.text,
            buttonText: toolbarButtonTextTextField.text,
            headerText: toolbarHeaderTextTextField.text
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
        return config
    }
}
