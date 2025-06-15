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
    
    lazy private var parser: TransactionParser = .init()
    
    func parseTransactions(from rawText: String) {
        Task {
            viewState = .loading
            let parsedTransactions: [BankTransaction] = await Task.detached(priority: .userInitiated) { [weak self] in
                guard let self else { return [] }
                return await self.parser.parse(rawText)
            }.value
            viewState = .success(parsedTransactions)
        }
    }

}
