//
//  CardDetailsViewController.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2Kit
import UIKit

var cardNumber: String = ""
var cardExpiryDate: Date?

class CardDetailsViewController: BaseViewController {
    // MARK: - Variables -
    
    var key: String = ""
    var salt: String = ""
    var amount: String = ""
    var email: String = ""
    var userCredential: String = ""
    
    var cardExpiryMonth: String = ""
    var cardExpiryYear: String = ""
    var cvv: String = ""
    var cardName: String = ""
    var cardToken: String = ""
    var networkToken: String = ""
    var config: PayU3DS2Config?
    var paymentParams: PayU3DS2PaymentParam?
    var paymentResponse: Any? = nil
    
    // MARK: - Private Variables -
    
    private var savedCards: [StoredCard] = []
    private var selectedIndex: Int?
    private var datePicker: UIDatePicker!
    private var toolBar: UIToolbar!
    
    // MARK: - IBOutlets -
    
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var cardExpiryTextField: UITextField!
    @IBOutlet var transactionIdTextField: UITextField!
    @IBOutlet var cvvTextField: UITextField!
    @IBOutlet var cardNameTextField: UITextField!
    @IBOutlet var savedSwitch: UISwitch!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var addNewCardStackView: UIStackView!
    @IBOutlet var savedCardTableView: UITableView!
    @IBOutlet var payButton: UIButton!
    @IBOutlet var cardTokenTextField: UITextField!
    @IBOutlet var networkTokenTextField: UITextField!
    @IBOutlet var isNetworkTokenFlow: UISwitch!
    @IBOutlet private var tokenStackView: UIStackView!
    @IBOutlet private var pgTextField: UITextField!
    @IBOutlet private var bankCodeTextField: UITextField!
    @IBOutlet private var acsTemplateTextField: UITextField!
    
    // AdditionalInfo
    @IBOutlet weak var additionalInfoSV: UIStackView!
    @IBOutlet weak var last4DigitsTextField: UITextField!
    @IBOutlet weak var tavvTextField: UITextField!
    @IBOutlet weak var tokenRefNoTextField: UITextField!
    @IBOutlet weak var tridTextField: UITextField!
    
    // SI: -
    @IBOutlet private var siOptionsStackView: UIStackView!
    @IBOutlet private var siOptionsSwitch: UISwitch!
    @IBOutlet weak var siEndDateTf: UITextField!
    @IBOutlet weak var siStartDateTf: UITextField!
    @IBOutlet weak var recurringAmountTf: UITextField!
    @IBOutlet weak var recurringIntervalTf: UITextField!
    @IBOutlet weak var recurringCycleTf: UITextField!
    @IBOutlet weak var recurringRemarksTextField: UITextField!
    
    private var siStartDate: Date = Date()
    private var siEndDate: Date = Date()
    private var recurringPeriod: PayU3DS2BillingCycle = .monthly
    
    // MARK: - Class Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        setUpDatePicker()
        cardNumberTextField.text = cardNumber
        cardExpiryTextField.text = cardExpiryDate?.stringFromDate(format: .mmyyyy, type: .local)
        configureLayoutVisiblity()
        updatePayButtonVisibility()
        updateTxnId()
        additionalInfoSV.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions -
    
    @IBAction func saveCardSwitchAction(_: Any) {
        view.endEditing(true)
    }
    
    @IBAction func crossButtonAction(_: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonAction(_: Any) {
        view.endEditing(true)
        prepareUserData()
        // Open SDK
        if config?.supportedUIMode.isEmpty ?? true {
            PayU3DS2SDKHelper.open(on: self, delegate: self, parameters: getUserDetailsDict(), config: config)
        } else {
            initiate3ds2Flow()
        }
    }
    
    @IBAction func ascWebRedirectButtonAction(_: UIButton) {
        view.endEditing(true)
        startWebViewRedirectionFlow()
    }
    
    @IBAction func payViaSavedCardToggle(_ sender: UISwitch) {
        if sender.isOn {
            tokenStackView.isHidden = false
        } else {
            tokenStackView.isHidden = true
        }
    }
    
    @IBAction func siOptionsToggle(_ sender: UISwitch) {
        if sender.isOn {
            paramsForSI()
            siOptionsStackView.isHidden = false
        } else {
            siOptionsStackView.isHidden = true
        }
    }
    
    @IBAction func additionalInfoToggle(_ sender: UISwitch) {
        if sender.isOn {
            additionalInfoSV.isHidden = false
        } else {
            last4DigitsTextField.text = nil
            tavvTextField.text = nil
            tokenRefNoTextField.text = nil
            tridTextField.text = nil
            additionalInfoSV.isHidden = true
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        if cardExpiryTextField.isFirstResponder {
            cardExpiryDate = sender.date
            updateExpiryDateTextField()
        } else if siStartDateTf.isFirstResponder {
            self.siStartDateTf.text = sender.date.dateString
            self.siStartDate = sender.date
        }
        else if siEndDateTf.isFirstResponder{
            self.siEndDateTf.text = sender.date.dateString
            self.siEndDate = sender.date
        }
    }
    
    @IBAction func billingCycleBtnAxn(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for billingCycle in PayU3DS2BillingCycle.allCases {
            sheet.addAction(UIAlertAction(title: PayU3DS2Utils.billingCycleToString(billingCycle), style: .default, handler: { (action) in
                self.recurringPeriod = billingCycle
                self.recurringCycleTf.text = action.title
            }))
        }
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = sheet.popoverPresentationController {
            popoverController.sourceView = self.view
            if UIDevice.current.userInterfaceIdiom == .pad {
                popoverController.sourceRect = CGRect.init(x:self.view.bounds.midX-150, y:self.view.bounds.midY-100,width:0,height:0)
            }
        }
        self.present(sheet, animated: true, completion: nil)
    }
    
    func initiate3ds2Flow() {
        Loader.shared.show()
        guard var paymentParams = PayU3DS2SDKHelper.getPaymentParameters(from: getUserDetailsDict())
        else  { return }
        self.paymentParams = paymentParams
        if let config = config {
            PayU3DS2.initialise(key: paymentParams.key, requestId: paymentParams.transactionId, config: config) { [weak self] wibmoSDKResponse in
                guard let self = self else {
                    Loader.shared.hide()
                    return
                }
                PayU3DS2SDKHelper.cardBinInfo(
                    withParameters: getUserDetailsDict(),
                    delegate: self,
                    isSIEnable: siOptionsSwitch.isOn
                ) { [weak self] response in
                    let response: PayU3DS2Response? = response
                    guard let self = self,
                          let response = response?.result as? PayU3DS2BinInfoResponse,
                          let cardType = response.cardType
                    else {
                        Loader.shared.hide()
                        self?.showAlert(title: "Error", message: response?.errorMessage)
                        return
                    }
                    let cardSchema: PayU3DS2CardScheme?
                    switch cardType {
                    case "MAST" :
                        cardSchema = .masterCard
                    case "VISA" :
                        cardSchema = .visa
                    default:
                        cardSchema = nil
                    }
                    if let cardSchema = cardSchema {
                        let cardData = PayU3DS2CardData(cardScheme: cardSchema, threeDSVersion: response.messageVersion ?? "")
                        paymentParams.cardinfo?.cardScheme = cardData.cardScheme
                        // Handle Response
                        if cardData.threeDSVersion.hasPrefix("2.") {
                            let deviceDetails = PayU3DS2.extractDeviceDetails(cardData: cardData)
                            guard let pArq = deviceDetails.result as? PayU3DS2PArqResponse
                            else {
                                Loader.shared.hide()
                                self.showAlert(title: "Error", message: deviceDetails.errorMessage)
                                return
                            }
                            PayU3DS2SDKHelper.mapPArq(toPaymentParams: paymentParams, pArq: pArq, authOnly: config.authenticateOnly, threeDSVersion: cardData.threeDSVersion)
                            // Uncomment the code to run headless flow and parallely make the callPaymentAPI public in PayU3DS2
                            PayU3DS2.callPaymentAPI(paymentParams: paymentParams, delegate: self) { error, flowType, challengeParameter in
                                    if error == nil {
                                        self.initiateChallenge(paymentParams: paymentParams,
                                                               flowType: flowType,
                                                               challengeParameter: challengeParameter)
                                    } else {
                                        Loader.shared.hide()
                                        self.showAlert(title: "Error", message: error)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        view.endEditing(true)
        addNewCardStackView.isHidden = sender.selectedSegmentIndex == 1
        savedCardTableView.isHidden = sender.selectedSegmentIndex != 1
        selectedIndex = nil
        let label = UILabel(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: 100))
        label.textAlignment = .center
        label.text = "Save Card Feature is in progress"
        savedCardTableView.backgroundView = label
        savedCardTableView.reloadData()
        //        fetchSavedCardsIfNeeded()
        prepareUserData()
        updatePayButtonVisibility()
    }
    
    @IBAction func textFieldDidChange(_: UITextField) {
        prepareUserData()
        updatePayButtonVisibility()
    }
    
    // MARK: - Private Functions -
    private func prefilldData() {
        //paramsForPg_BankCodeEMI()
        
        //paramsCardTokenAndNetworkTokenBoth()
        
        //paramsNetworkTokenCardFlow()
        //paramsPayUTokenCardFlow()
        paramsNoralCardFlow()
    }
    
    private func paramsForPg_BankCodeEMI() {
        // EMI test card
        //isProductionSwitch.isOn = false
        cardNumberTextField.text = "4808557848741463"
        cardExpiryTextField.text = "05/30"
        cvvTextField.text = "123"
        amount = "9000"
        pgTextField.text = "EMI"
        bankCodeTextField.text = "EMIIC3"
        
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = -2 //5
        dateComponent.year = 5 //30
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        cardExpiryDate = futureDate
    }
    
    private func paramsNoralCardFlow() {
        // PROD testing
        cardNameTextField.text = ""
        cardNumberTextField.text = ""
        cardExpiryTextField.text = ""
        cvvTextField.text = ""
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = 3
        dateComponent.year = 5
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        cardExpiryDate = futureDate
    }
    
    private func paramsNetworkTokenCardFlow() {
        tokenStackView.isHidden = false
        
        networkTokenTextField.text = ""
        cardExpiryTextField.text = ""
        //cvvTextField.text = "382" // Optional
        cardNameTextField.text = "" // Optional
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = -3
        dateComponent.year = 3 //28
        isNetworkTokenFlow.isOn = true //cardTokenType = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        cardExpiryDate = futureDate
    }
        
    private func getAdditionalParamsForNetworkTokenisedCards() -> [String: Any] {
        var dict = [String: Any]()
        dict[SampleAppConstants.last4Digits] = last4DigitsTextField.text
        dict[SampleAppConstants.tavv] = tavvTextField.text
        dict[SampleAppConstants.tokenRefNo] = tokenRefNoTextField.text
        dict[SampleAppConstants.trid] = tridTextField.text
        return dict
    }
    
    private func paramsPayUTokenCardFlow() { // CardToken flow
        cardTokenTextField.text = ""
        tokenStackView.isHidden = false
    }
    
    private func paramsCardTokenAndNetworkTokenBoth() {
        paramsPayUTokenCardFlow()
        isNetworkTokenFlow.isOn = false //cardTokenType no needed, otherwise it will treat as networkFlow
        
        networkTokenTextField.text = ""
        isNetworkTokenFlow.isOn = false
    }
    
    private func paramsForSI() {
        // SI with Card
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = 3 //10
        dateComponent.year = 5 //30
        
         let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
         cardExpiryDate = futureDate
        
        recurringAmountTf.text = "1"
        recurringIntervalTf.text = "1"
        recurringRemarksTextField.text = "Hi this is test si 3DS"
    }
    
    private func setUpDatePicker() {
        // DatePicker
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.center = view.center
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        // ToolBar
        toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92 / 255, green: 216 / 255, blue: 255 / 255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        toolBar.setItems([spaceButton, cancelButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.isHidden = false
        
        cardExpiryTextField.inputAccessoryView = toolBar
        cardExpiryTextField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        siStartDateTf?.inputAccessoryView = toolBar
        siEndDateTf?.inputAccessoryView = toolBar
        //add datepicker to textField
        siStartDateTf?.inputView = datePicker
        siEndDateTf?.inputView = datePicker
        
        //Default current date
        siStartDateTf?.text =  Date().dateString
        siEndDateTf?.text =  Date().dateString
    }
    
    @objc func doneClick() {
        view.endEditing(true)
        self.siStartDateTf.resignFirstResponder()
        self.siEndDateTf.resignFirstResponder()
    }
    
    private func configureLayoutVisiblity() {
        tokenStackView.isHidden = false
        siOptionsStackView.isHidden = false
        recurringCycleTf.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    private func updatePayButtonVisibility() {
        //        let isEnable = (!cardNumber.isEmpty && !cardExpiryYear.isEmpty && !cardExpiryMonth.isEmpty && !cvv.isEmpty && !cardName.isEmpty)
        //        payButton.isUserInteractionEnabled = isEnable
        //        payButton.backgroundColor = payButton.backgroundColor?.withAlphaComponent(isEnable ? 1 : 0.5)
    }
    
    private func updateTxnId() {
        DispatchQueue.main.async {
            self.transactionIdTextField.text = "iOS\(Int64(Date().timeIntervalSince1970))"
        }
    }
    
    private func updateExpiryDateTextField() {
        cardExpiryTextField.text = cardExpiryDate?.stringFromDate(format: .mmyyyy, type: .local)
    }
    
    private func fetchSavedCardsIfNeeded() {
        if savedCards.isEmpty && segmentControl.selectedSegmentIndex == 1 {
            Loader.shared.show()
            //            SavedCardsAPI.fetchAll(paymentParam: getPaymentParamToFetchSavedCards()) { cards in
            //                DispatchQueue.main.async {
            //                    self.savedCards = cards
            //                    self.savedCardTableView.reloadData()
            //                    Loader.shared.hide()
            //                }
            //            }
        }
    }
    
    private func prepareUserData() {
        guard let selectedIndex = selectedIndex else {
            // New Card
            cardNumber = cardNumberTextField.text ?? ""
            cardExpiryMonth = cardExpiryDate?.stringFromDate(format: .mm, type: .local) ?? ""
            cardExpiryYear = cardExpiryDate?.stringFromDate(format: .yyyy, type: .local) ?? ""
            cvv = cvvTextField.text ?? ""
            cardName = cardNameTextField.text ?? ""
            cardToken = cardTokenTextField.text ?? ""
            networkToken = networkTokenTextField.text ?? ""
            return
        }
        // Saved Card
        cardNumber = savedCards[selectedIndex].number
        cardExpiryMonth = savedCards[selectedIndex].month
        cardExpiryYear = savedCards[selectedIndex].year
        cardName = savedCards[selectedIndex].name
        cvv = savedCards[selectedIndex].cvv ?? ""
        cardToken = savedCards[selectedIndex].token ?? ""
    }
    
    private func getUserDetailsDict() -> [String: Any] {
        var dict = [String: Any]()
        dict[SampleAppConstants.amount] = amount
        dict[SampleAppConstants.key] = key
        dict[SampleAppConstants.salt] = salt
        dict[SampleAppConstants.email] = email
        dict[SampleAppConstants.cardNumber] = cardNumber
        dict[SampleAppConstants.cardExpiryMonth] = cardExpiryMonth
        dict[SampleAppConstants.cardExpiryYear] = cardExpiryYear
        dict[SampleAppConstants.cardName] = cardName
        dict[SampleAppConstants.cvv] = cvv
        dict[SampleAppConstants.cardToken] = cardToken
        dict[SampleAppConstants.networkToken] = networkToken
        dict[SampleAppConstants.cardTokenType] = isNetworkTokenFlow.isOn ? "1" : "0" // ignore if 0
        dict[SampleAppConstants.partnerWebhookSuccess] = "https://cbjs.payu.in/sdk/success"
        dict[SampleAppConstants.partnerWebhookFailure] = "https://cbjs.payu.in/sdk/failure"
        if isNetworkTokenFlow.isOn {
            // Requuired only incase of Network token payment flow
            dict[SampleAppConstants.additionalParam] = getAdditionalParamsForNetworkTokenisedCards()
        }
        dict[SampleAppConstants.userCredential] = userCredential
        dict[SampleAppConstants.saveCard] = savedSwitch.isOn
        dict[SampleAppConstants.transactionId] = transactionIdTextField.text ?? ""
        dict[SampleAppConstants.pg] = pgTextField.text ?? ""
        dict[SampleAppConstants.bankcode] = bankCodeTextField.text ?? ""
        if let siInfo = getSIParamsDict(), !siInfo.isEmpty {
            dict[SampleAppConstants.siPaymentInfo] = siInfo
        }
        return dict
    }
    
    private func getSIParamsDict() -> [String: Any]? {
        if let recurringAmount = recurringAmountTf.text,
           let frequency = recurringIntervalTf.text,
            let frequencyInt = Int(frequency), siOptionsSwitch.isOn {
            var dict = [String: Any]()
            dict[SampleAppConstants.billingAmount] = recurringAmount
            dict[SampleAppConstants.billingCycle] = recurringPeriod
            dict[SampleAppConstants.siStartDate] = self.siStartDate
            dict[SampleAppConstants.siEndDate] = self.siEndDate
            dict[SampleAppConstants.billingInterval] = frequencyInt //NSNumber(value: frequencyInt)
            dict[SampleAppConstants.remarks] = recurringRemarksTextField.text?.isEmpty ?? true ? nil : recurringRemarksTextField.text
            dict[SampleAppConstants.billingLimit] = "ON"
            dict[SampleAppConstants.billingRule] = "MAX"
            return dict
        }
        return nil
    }
    
    //    private func getPaymentParamToFetchSavedCards() -> PayUModelPaymentParams {
    //        let paymentParam = PayUModelPaymentParams()
    //        paymentParam.key = key
    //        paymentParam.hashes.paymentRelatedDetailsHash = getPaymentRelatedDetailsHash()
    //        paymentParam.userCredentials = userCredential
    //        return paymentParam
    //    }
    
    //    private func getPaymentParamToSaveNewCard(_ dict: [String: Any]) -> PayUModelPaymentParams {
    //        let paymentParam = PayUModelPaymentParams()
    //        paymentParam.key = key
    //        paymentParam.userCredentials = userCredential
    //        paymentParam.cardName = cardName
    //        paymentParam.cardMode = "DC"
    //        paymentParam.cardType = dict[SampleAppConstants.bankcode] as? String ?? ""
    //        paymentParam.nameOnCard = cardName
    //        paymentParam.cardNo = cardNumber
    //        paymentParam.expiryMonth = cardExpiryMonth
    //        paymentParam.expiryYear = cardExpiryYear
    //        paymentParam.duplicateCheck = "1"
    //        let hashString = "\(key)|save_user_card|\(userCredential)|\(salt)"
    //        paymentParam.hashes.saveUserCardHash = PayUDontUseThisClass().getHash(hashString)
    //
    //        return paymentParam
    //    }
    
    private func saveUserCardIfNeeded(_: String?) {
        //        if !savedSwitch.isOn {
        //            return
        //        }
        //        guard let data = response?.data(using: .utf8) else { return }
        //        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as?  [String: Any] else { return }
        //        SavedCardsAPI.saveCard(paymentParam: getPaymentParamToSaveNewCard(json))
    }
    
    //    private func getPaymentRelatedDetailsHash() -> String {
    //        let hashString = (key + "|" + COMMAND_PAYMENT_RELATED_DETAILS_FOR_MOBILE_SDK + "|" + PayUUtils.passEmptyStringFornilValues(userCredential) + "|" + salt)
    //        return PayUDontUseThisClass().getHash(hashString)
    //    }
    private func initiateChallenge(
        paymentParams: PayU3DS2PaymentParam,
        flowType: String?,
        challengeParameter: PayU3DS2ChallengeParameter?
    ) {
        switch flowType {
        case "C":
            if let challengeParameter = challengeParameter {
                if config?.enableMFAViaBiometric == true {
                    // 3DS with MFA supported
                    PayU3DS2.initiateChallengeWithMFA(challengeParameter: challengeParameter, vc: self, delegate: self)
                } else {
                    // 3DS supported only
                    PayU3DS2.initiateChallenge(challengeParameter: challengeParameter, vc: self) { [weak self] response in
                        self?.handleInitateChallengeResponse(response)
                    }
                }
            } else {
                    Loader.shared.hide()
            }
        default:
            Loader.shared.hide()
        }
    }
    
    private func handleInitateChallengeResponse(_ response: PayU3DS2Response?) {
        DispatchQueue.main.async {
            if let response = response?.result as? PayU3DS2HeadlessData,
               let vc = self.storyboard?.instantiateViewController(withIdentifier: VerifyOTPViewController.className) as? VerifyOTPViewController {
                Loader.shared.hide()
                vc.setupView(image1: response.issuerImage?.high,
                             image2: response.networkImage?.high,
                             otpSentText: response.challengeInfoText,
                             resendButtonVisible: response.challengeInfoText == nil ? false : true )
                vc.challengeInputParameters = PayU3DS2ACSActionParams(acsRenderingType: response.acsRenderingType, acsTransactionID: response.acsTransactionID)
                vc.showAlertMessage = { message in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        self.showAlert(title: message, message: "")
                    }
                }
                self.present(vc, animated: true)
            } else {
                print("Check3DS onSuccess MA response: \(response?.result.debugDescription) ")
                self.showAlert(title: "Response", message: response?.result.debugDescription)
                if let transactionStatus = (response?.result as? [String: String])?["transactionStatus"], transactionStatus == "Y" {
                    if self.config?.authenticateOnly == true {
                        self.authenticatePayment()
                    } else if let paymentParams = self.paymentParams {
                        self.authorisePayment(paymentParams: paymentParams)
                    } else {
                        Loader.shared.hide()
                    }
                } else {
                    Loader.shared.hide()
                }
            }
            
        }
    }
    
    private func authorisePayment(
        paymentParams: PayU3DS2PaymentParam
    ) {
        PayU3DS2.authorisePayment(paymentParams: paymentParams, delegate: self)
    }
    
    private func authenticatePayment() {
        PayU3DS2.authenticatePayment(delegate: self)
    }

    private func startWebViewRedirectionFlow() {
        let params = PayU3DS2SDKHelper.getRedirectionFlowParameters(
            withAcsTemplate: acsTemplateTextField.text ?? "",
            surl: "https://cbjs.payu.in/sdk/success",
            furl: "https://cbjs.payu.in/sdk/failure",
            merchantResponseTimeout: 10,
            autoSubmit: true,
            autoRead: true
        )
        PayU3DS2SDKHelper.startRedirectionFlow(
            on: self,
            parameters: params,
            delegate: self
        )
    }
}

extension CardDetailsViewController: PayU3DS2Delegate {
    func generateHash(for param: [String: String], onCompletion: @escaping PayU3DS2HashGenerationCompletion) {
        let commandName = param[PayU3DS2HashConstants.hashName] ?? ""
        let hashStringWithoutSalt = param[PayU3DS2HashConstants.hashString] ?? ""
        let postSalt = param[PayU3DS2HashConstants.postSalt] ?? ""
        // get hash for "commandName" from server
        // get hash for "hashStringWithoutSalt" from server
        // After fetching hash from server and set its value in below variable "hashValue"
        var hashValue = "<Provide your calculative hash here>"
        onCompletion([commandName: hashValue])
    }
    
    func onPaymentSuccess(successResponse: Any?) {
        Loader.shared.hide()
        print("onPaymentSuccess = \(String(describing: successResponse))")
        showAlert(title: "onPaymentSuccess", message: successResponse)
        updateTxnId()
    }
    
    func onPaymentFailure(failureResponse: Any?) {
        Loader.shared.hide()
        print("onPaymentFailure = \(String(describing: failureResponse))")
        showAlert(title: "onPaymentFailure", message: failureResponse)
        updateTxnId()
    }
    
    func onPaymentCancel(isTxnInitiated: Bool) {
        print("txn cancel")
        Loader.shared.hide()
        showAlert(title: "onPaymentCancel", message: "\(isTxnInitiated)")
        updateTxnId()
    }
    
    func onError(errorCode: Int, errorMessage: String) {
        Loader.shared.hide()
        print("onError = \(String(describing: errorMessage))")
        showAlert(title: "onError", message: "errorCode: \(errorCode), errorMessage: \(errorMessage)")
        updateTxnId()
    }

}
// MARK: - UITableViewDataSource -

extension CardDetailsViewController: PayU3DS2IniitateChallengeDelegate {
    func onInitateChallenge(response: Any?) {
        handleInitateChallengeResponse(response as? PayU3DS2Response)
    }
    
    func mfaRegistrationStatus(response: Any?) {
        DispatchQueue.main.async {
            if let resp = response as? PayU3DS2MFAResponse {
                let typeString: String
                switch resp.type {
                case .registration:  typeString = "registration"
                case .deregistration: typeString = "deregistration"
                @unknown default: typeString = "unknown"
                }

                let statusString: String
                switch resp.status {
                case .initiated: statusString = "initiated"
                case .success:   statusString = "success"
                case .error:     statusString = "error"
                @unknown default: statusString = "unknown"
                }

                let message = """
                Response Type: \(typeString), Response Status: \(statusString), Response Timeout: \(resp.timeout)
                """

                self.showAlert(title: "MFA Registration Status", message: message)
            } else {
                self.showAlert(title: "MFA Registration Status", message: "Response is nil")
            }

        }
    }
}

extension CardDetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        savedCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        (cell.contentView.viewWithTag(10) as? UILabel)?.text = savedCards[indexPath.row].number
        (cell.contentView.viewWithTag(11) as? UITextField)?.text = savedCards[indexPath.row].cvv
        (cell.contentView.viewWithTag(11) as? UITextField)?.isHidden = indexPath.row != selectedIndex
        (cell.contentView.viewWithTag(11) as? UITextField)?.addTarget(self, action: #selector(cvvDidChange(_:)), for: .editingChanged)
        cell.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        return cell
    }
    
    @objc func cvvDidChange(_ sender: UITextField) {
        guard let selectedIndex = selectedIndex else { return }
        savedCards[selectedIndex].cvv = sender.text
        prepareUserData()
        updatePayButtonVisibility()
    }
}

// MARK: - UITableViewDelegate -

extension CardDetailsViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        savedCards[indexPath.row].cvv = nil
        selectedIndex = indexPath.row
        savedCardTableView.reloadData()
        prepareUserData()
        updatePayButtonVisibility()
    }
}

extension NSObject {
  var className: String {
    return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
  }
  
  class var className: String {
    return String(describing: self).components(separatedBy: ".").last ?? ""
  }
}

