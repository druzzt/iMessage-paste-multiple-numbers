//
//  ViewController.swift
//  iMessagePasteNumbers
//
//  Created by Arkadiusz Lewandowski on 24/06/2021.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    var pastebinPayload: String = getPastebin()

    @IBOutlet weak var separatorsTextField: UITextField!
    @IBOutlet weak var phoneNumbersTextView: UITextView!
    @IBOutlet weak var textMessageTextView: UITextView!

    @IBAction func readyButtonAction(_ sender: UIButton) {
        assembleMessage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fillPhoneNumbersTextView()
        fillSeparatorsTextField()
    }

}

extension ViewController {
    func fillSeparatorsTextField() {
        self.separatorsTextField.text = getPotentialSeparator()
    }
    func fillPhoneNumbersTextView() {
        self.phoneNumbersTextView.text = getPastebinNumbers()
    }
}

extension ViewController {
    static func getPastebin() -> String {
        if UIPasteboard.general.hasStrings {
            return UIPasteboard.general.string ?? ""
        }
        return ""
    }
    func getPastebinNumbers() -> String {
        return pastebinPayload
    }
    func getPotentialSeparator() -> String {
        let potentialSeparators = [",", ";", ".", "&", " "]
        var potentialSeparator = ""
        for separator in potentialSeparators {
            if pastebinPayload.contains(separator) {
                potentialSeparator = separator
            }
        }
        return potentialSeparator
    }
}

extension ViewController {
    func assembleMessage() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        // Configure the fields of the interface.
        composeVC.recipients = assemblePhoneNumbers()
        composeVC.body = assembleTextMessage()

        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    func assemblePhoneNumbers() -> [String] {
        return ["+48505862590", "+48725730523"]
    }
    func assembleTextMessage() -> String {
        return "Hello from iMessagesPasteNumbers App!"
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        debugPrint(#function, #line, controller, result)
    }

}
