//
//  BankCardViewModel.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/26/25.
//

import Foundation

@MainActor
final class BankCardViewModel: ObservableObject {
    let account: BankAccountInfo
    @Published var isBalanceVisible = false
    
    init(account: BankAccountInfo) {
        self.account = account
    }
}
