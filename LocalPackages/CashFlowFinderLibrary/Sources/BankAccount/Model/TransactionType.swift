//
//  TransactionType.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import SwiftUI

enum TransactionType: String, CaseIterable {
    case all = "All"
    case deposit = "Deposit"
    case withdrawal = "Withdrawal"
    case charges = "Charges"
    
    var icon: String {
        switch self {
        case .all: return "list.bullet"
        case .deposit: return "arrow.down.circle.fill"
        case .withdrawal: return "arrow.up.circle.fill"
        case .charges: return "exclamationmark.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .all: return .blue
        case .deposit: return .green
        case .withdrawal: return .red
        case .charges: return .orange
        }
    }
}
