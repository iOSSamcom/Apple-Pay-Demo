//
//  ViewController.swift
//  ApplePayDemo
//
//  Created by Parth on 31/07/20.
//  Copyright © 2020 Samcom. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func payBtnClicked(_ sender: UIButton) {
         openNormalApplePay()
        
    }
    
}

extension ViewController:PKPaymentAuthorizationViewControllerDelegate{
    // Apple pay
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        controller.dismiss(animated: true, completion: nil)
        if let _ : PKPayment = payment {
            let alert = UIAlertController(title: "", message: "PAYMENT SUCCESSFULLY", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func openNormalApplePay() {
        if PKPaymentAuthorizationViewController.canMakePayments(){
            
            let request = PKPaymentRequest()
        
            //capabilities of your transaction
            request.supportedNetworks = [.visa,.amex,.masterCard,.maestro,.discover]
            request.merchantIdentifier = "merchant.com.ios.applePayDemo"
            request.merchantCapabilities = .capabilityEMV
            request.countryCode = "US"
            request.currencyCode = "USD"
            //if you want to add shipping
            request.shippingContact = .some(PKContact())

            
            var itemArr = [PKPaymentSummaryItem]()
            
            let v1 = PKPaymentSummaryItem(label: "SUBTOTAL", amount: Decimal(string: "10.00")! as NSDecimalNumber)
            itemArr.append(v1)
            let v2 = PKPaymentSummaryItem(label: "SALESTAX", amount: Decimal(string: "10.00")! as NSDecimalNumber)
            itemArr.append(v2)
            let v3 = PKPaymentSummaryItem(label: "DEMO", amount: Decimal(string: "20.00")! as NSDecimalNumber)
            
            itemArr.append(v3)
            request.paymentSummaryItems = itemArr
            
            //Creating a Payment Request
            let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
            applePayController?.delegate = self
            self.present(applePayController!, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "", message: "Sorry, your device not supporting applepay", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
           
        }
    }
}

