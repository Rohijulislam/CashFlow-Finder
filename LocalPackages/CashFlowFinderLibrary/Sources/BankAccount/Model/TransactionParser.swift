//
//  TransactionParser.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import Foundation

struct TransactionParser {
    
    // MARK: - Main parsing
    
    func parse(_ raw: String) -> [BankTransaction] {
        let lines = preprocessLines(from: raw)
        return parseTransactions(from: lines)
    }
    
    func parseBankAccountInfo(from text: String) -> BankAccountInfo {
        guard let currencyRange = text.range(of: "Currency") else {
            return BankAccountInfo(
                customerName: "JOHN DOE",
                printDate: nil, periodFrom: nil, periodTo: nil,
                accountNumber: "XXXXXXXXXX", customerID: nil, productName: nil,
                currency: "BDT"
            )
        }
        
        let customerName: String
        #if DEBUG
        customerName = "MD. ROHEJUL ISLAM"
        #else
        customerName = "JOHN DOE"
        #endif

        let textUpToCurrency = String(text[..<currencyRange.upperBound])
        // Other fields via regex
        let printDate = extractFirstMatch(pattern: #"Print Date\s*:\s*([0-9-]+)"#, in: textUpToCurrency)
        let periodFrom = extractFirstMatch(pattern: #"Period From\s*:\s*([0-9-]+)"#, in: textUpToCurrency)
        let periodTo = extractFirstMatch(pattern: #"To\s*([0-9-]+)"#, in: textUpToCurrency)
        let accountNumber = extractFirstMatch(pattern: #"Account Number\s*:\s*([0-9X]+)"#, in: textUpToCurrency) ?? "XXXXXXXXXX"
        let customerID = extractFirstMatch(pattern: #"Customer ID\s*:\s*([A-Z0-9X]+)"#, in: textUpToCurrency)
        let productName = extractFirstMatch(pattern: #"Product Name\s*:\s*(.+)"#, in: textUpToCurrency)

        return BankAccountInfo(
            customerName: customerName,
            printDate: printDate,
            periodFrom: periodFrom,
            periodTo: periodTo,
            accountNumber: accountNumber,
            customerID: customerID,
            productName: productName,
            currency: "BDT"
        )
    }

    
    // MARK: - Helpers
    
    private func extractFirstMatch(pattern: String, in text: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        if let match = regex?.firstMatch(in: text, options: [], range: range),
           let range = Range(match.range(at: 1), in: text) {
            return String(text[range]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }
    
    private func preprocessLines(from raw: String) -> [String] {
        let datePattern = #"^\d{2}-\d{2}-\d{4}"#
        let lines = raw.components(separatedBy: .newlines)
        var combinedLines: [String] = []
        var buffer = ""
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
            guard !trimmed.isEmpty, !trimmed.allSatisfy({ $0 == "_" }) else { continue }
            
            if trimmed.contains("Total Withdrawal") {
                if !buffer.isEmpty { combinedLines.append(buffer) }
                break
            }
            
            if trimmed.range(of: datePattern, options: .regularExpression) != nil {
                if !buffer.isEmpty { combinedLines.append(buffer) }
                buffer = trimmed
            } else {
                buffer += " \(trimmed)"
            }
        }
        
        if !buffer.isEmpty { combinedLines.append(buffer) }
        return combinedLines
    }
    
    private func parseTransactions(from lines: [String]) -> [BankTransaction] {
        var transactions: [BankTransaction] = []
        var lastBalance: Double = 0
        
        for line in lines {
            let parts = line.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
            guard (4...9).contains(parts.count) else {
                print("⚠️ Skipped line: \(parts)")
                continue
            }
            
            guard let date = DateFormatter.transactionDate.date(from: parts[0]) else {
                print("⚠️ Invalid date: \(parts[0])")
                continue
            }
            
            let amountAndBalance = parts.suffix(2).map { $0.replacingOccurrences(of: ",", with: "") }
            guard let amount = Double(amountAndBalance.first ?? ""),
                  let balance = Double(amountAndBalance.last ?? "") else {
                print("⚠️ Invalid amount/balance: \(amountAndBalance)")
                continue
            }
            
            let description = parts[1..<(parts.count - 2)].joined(separator: " ")
            
            // Determine if it's deposit or withdrawal
            let isDeposit = balance > lastBalance
            lastBalance = balance
            
            let transaction = BankTransaction(
                date: date,
                description: description,
                withdrawal: isDeposit ? nil : amount,
                deposit: isDeposit ? amount : nil,
                balance: balance
            )
            
            transactions.append(transaction)
        }
        
        return transactions
    }
}
