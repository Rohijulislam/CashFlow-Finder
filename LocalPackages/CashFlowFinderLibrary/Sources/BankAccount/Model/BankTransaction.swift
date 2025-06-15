//
//  BankTransaction.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import Foundation

struct BankTransaction: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
    let withdrawal: Double?
    let deposit: Double?
    let balance: Double
    
    // Convenience
    var dateText: String { DateFormatter.transactionDate.string(from: date) }
    var depositText: String? { deposit.map(BankTransaction.formatter.string) }
    var withdrawalText: String? { withdrawal.map(BankTransaction.formatter.string) }
    var balanceText: String { BankTransaction.formatter.string(from: balance as NSNumber) ?? "" }
    
    static let formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    var amount: Double {
        return deposit ?? -(withdrawal ?? 0)
    }
    
    var isDeposit: Bool {
        return deposit != nil
    }
    
    var transactionType: TransactionType {
        return isDeposit ? .deposit : .withdrawal
    }
}

extension NumberFormatter {
    func string(_ value: Double) -> String { string(from: value as NSNumber) ?? "" }
}

extension DateFormatter {
    static let transactionDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter
    }()
}
