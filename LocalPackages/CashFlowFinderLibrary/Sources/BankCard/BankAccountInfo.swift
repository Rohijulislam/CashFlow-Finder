//
//  BankAccountInfo.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/17/25.
//

import Foundation

public struct BankAccountInfo {
    let customerName: String
    let printDate: String?
    let periodFrom: String?
    let periodTo: String?
    let accountNumber: String
    let customerID: String?
    let productName: String?
    let currency: String
    
    public init(customerName: String, printDate: String?, periodFrom: String?, periodTo: String?, accountNumber: String, customerID: String?, productName: String?, currency: String) {
        self.customerName = customerName
        self.printDate = printDate
        self.periodFrom = periodFrom
        self.periodTo = periodTo
        self.accountNumber = accountNumber
        self.customerID = customerID
        self.productName = productName
        self.currency = currency
    }
    
     var bankName: String {
        return "City Bank"
    }
    
    var bankCode: String {
        return "CB"
    }
}
