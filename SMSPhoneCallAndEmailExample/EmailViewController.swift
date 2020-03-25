//
//  EmailViewController.swift
//  SMSPhoneCallAndEmailExample
//
//  Created by moxDroid on 2018-03-05.
//  Copyright © 2018 moxDroid. All rights reserved.
//

import UIKit
import MessageUI
import Contacts

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {
   
    @IBOutlet var subject: UITextField!
    @IBOutlet var body: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func sendMail(sender: AnyObject)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setToRecipients(["pritam.world@gmail.com"])
            picker.setSubject(subject.text!)
            picker.setMessageBody(body.text!, isHTML: true)
            
            present(picker, animated: true, completion: nil)
        }else{
            print("NO Email Client exist")
        }
    }
    @IBAction func iFetchContacts(_ sender: UIButton) {
//        let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: "Appleseed")
//        print(predicate)
//        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
//        print(keysToFetch)
//        let keysToFetching = [CNContactEmailAddressesKey, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)] as [Any]
//        print(keysToFetching)
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                        CNContactPhoneNumbersKey,
                        CNContactEmailAddressesKey
                ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                    (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
                    }
                }
            }
            print(contacts)
        } catch {
            print("unable to fetch contacts")
        }    }
    
    // MFMailComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
}
