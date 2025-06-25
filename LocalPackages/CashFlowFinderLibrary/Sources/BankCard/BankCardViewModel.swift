//
//  BankCardViewModel.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/26/25.
//

import Foundation
import SwiftUI

@MainActor
final class BankCardViewModel: ObservableObject {
    let account: BankAccountInfo
    @Published var isBalanceVisible = false
    
    init(account: BankAccountInfo) {
        self.account = account
    }
    
    var balanceTransition: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.1)),
            removal: .opacity.combined(with: .scale(scale: 0.9))
        )
    }
    
    func toggleBalanceVisibility() {
        withAnimation(.spring(
            response: 0.3,
            dampingFraction: 0.7
        )) {
            isBalanceVisible.toggle()
        }
    }
}
