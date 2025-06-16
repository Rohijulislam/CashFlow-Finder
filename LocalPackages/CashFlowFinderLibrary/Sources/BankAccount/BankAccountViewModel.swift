//
//  BankAccountViewModel.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import Foundation
import Shared

@MainActor
final class BankAccountViewModel: ObservableObject {
    @Published var viewState: ViewState<[BankTransaction]> = .empty
    @Published var accountInfo: BankAccountInfo?
    
    lazy private var parser: TransactionParser = .init()
    
    func parseTransactions(from rawText: String) {
        // Parse static account info synchronously
        accountInfo = parser.parseBankAccountInfo(from: rawText)
        
        // Kick off background parsing of transactions
        Task { 
            viewState = .loading
            do {
                let transactions = try await parseTransactionsAsync(from: rawText)
                viewState = .success(transactions)
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }

    // MARK: - Async Helper
    
    private func parseTransactionsAsync(from rawText: String) async throws -> [BankTransaction] {
        return await Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return [] }
            return await self.parser.parse(rawText)
        }.value
    }

}
