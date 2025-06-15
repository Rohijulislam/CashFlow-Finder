//
//  TransactionParser.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import Foundation

struct TransactionParser {
    
    func parse(_ raw: String) -> [BankTransaction] {
        let lines = preprocessLines(from: raw)
        return parseTransactions(from: lines)
    }
    
    // MARK: - Helpers
    
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
