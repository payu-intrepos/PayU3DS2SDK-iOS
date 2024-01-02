//
//  CardDetailsViewController.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2Kit
import UIKit
// import PayUBizCoreKit
// import PayUCustomBrowser

class CardDetailsViewController: BaseViewController {
    // MARK: - Variables -

    var key: String = ""
    var salt: String = ""
    var amount: String = ""
    var email: String = ""
    var userCredential: String = ""
    var transactionId: String = ""

    var cardNumber: String = ""
    var cardExpiryMonth: String = ""
    var cardExpiryYear: String = ""
    var cvv: String = ""
    var cardName: String = ""
    var cardToken: String = ""
    var networkToken: String = ""

    var config: PayU3DS2Config?

    // MARK: - Private Variables -

    private var savedCards: [StoredCard] = []
    private var selectedIndex: Int?
    private var datePicker: UIDatePicker!
    private var toolBar: UIToolbar!
    private var cardExpiryDate: Date?

    // MARK: - IBOutlets -

    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var cardExpiryTextField: UITextField!
    @IBOutlet var cvvTextField: UITextField!
    @IBOutlet var cardNameTextField: UITextField!
    @IBOutlet var savedSwitch: UISwitch!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var addNewCardView: UIView!
    @IBOutlet var savedCardTableView: UITableView!
    @IBOutlet var payButton: UIButton!
    @IBOutlet var cardTokenTextField: UITextField!
    @IBOutlet var networkTokenTextField: UITextField!

    // MARK: - Class Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatePicker()
        updatePayButtonVisibility()
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
        PayU3DS2SDKHelper.open(on: self, delegate: self, parameters: getUserDetailsDict(), config: config)
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        view.endEditing(true)
        addNewCardView.isHidden = sender.selectedSegmentIndex == 1
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
    }

    @objc func doneClick() {
        view.endEditing(true)
    }

    @objc func handleDatePicker(sender: UIDatePicker) {
        cardExpiryDate = sender.date
        updateExpiryDateTextField()
    }

    private func updatePayButtonVisibility() {
//        let isEnable = (!cardNumber.isEmpty && !cardExpiryYear.isEmpty && !cardExpiryMonth.isEmpty && !cvv.isEmpty && !cardName.isEmpty)
//        payButton.isUserInteractionEnabled = isEnable
//        payButton.backgroundColor = payButton.backgroundColor?.withAlphaComponent(isEnable ? 1 : 0.5)
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
        dict[SampleAppConstants.userCredential] = userCredential
        dict[SampleAppConstants.saveCard] = savedSwitch.isOn
        dict[SampleAppConstants.transactionId] = transactionId
        return dict
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
}

extension CardDetailsViewController: PayU3DS2Delegate {
    func generateHash(for param: [String: String], onCompletion: @escaping PayU3DS2HashGenerationCompletion) {
        let commandName = param[PayU3DS2HashConstants.hashName] ?? ""
        let hashStringWithoutSalt = param[PayU3DS2HashConstants.hashString] ?? ""
        let postSalt = param[PayU3DS2HashConstants.postSalt] ?? ""
        // get hash for "commandName" from server
        // get hash for "hashStringWithoutSalt" from server
        // After fetching hash set its value in below variable "hashValue"
        var hashValue = Utils.sha512Hex(string: hashStringWithoutSalt + salt + postSalt)
        onCompletion([commandName: hashValue])
    }

    func onPaymentSuccess(successResponse: Any?) {
        print(successResponse)
        showAlert(title: "onPaymentSuccess", message: successResponse)
    }

    func onPaymentFailure(failureResponse: Any?) {
        print(failureResponse)
        showAlert(title: "onPaymentFailure", message: failureResponse)
    }

    func onPaymentCancel(isTxnInitiated: Bool) {
        print("txn cancel")
        showAlert(title: "onPaymentCancel", message: "\(isTxnInitiated)")
    }

    func onError(errorCode: Int, errorMessage: String) {
        print(errorMessage)
        showAlert(title: "onError", message: "errorCode: \(errorCode), errorMessage: \(errorMessage)")
    }
}

// MARK: - UITableViewDataSource -

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
