//
//   BankCardView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/26/25.
//

import SwiftUI

public struct BankCardView: View {
    @StateObject private var viewModel: BankCardViewModel
    
    public init(account: BankAccountInfo) {
        _viewModel = StateObject(wrappedValue: BankCardViewModel(account: account))
    }
    
    public var body: some View {
        ZStack {
            cardBackground
            cardContent
        }
        .frame(height: 200)
        .padding(.horizontal, 24)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.black)
    }
    
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerRow
            Spacer()
            balanceSection
            Spacer()
            accountInfoSection
        }
    }
    
    var headerRow: some View {
        HStack {
            bankLogo
            Spacer()
            balanceVisibilityToggle
        }
        .padding(.top, 12)
        .padding(.horizontal, 24)
    }
    
    var bankLogo: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(.white.opacity(0.2))
                .frame(width: 32, height: 32)
                .overlay(bankCodeText)
            
            Text(viewModel.account.bankName)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
        }
    }
    
    var bankCodeText: some View {
        Text(viewModel.account.bankCode)
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(.white)
    }
    
    var balanceVisibilityToggle: some View {
        Button(action: {
            viewModel.toggleBalanceVisibility()
        }) {
            Image(systemName: viewModel.isBalanceVisible ? "eye.fill" : "eye.slash.fill")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .frame(width: 44, height: 44)
        }
    }
    
    var balanceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            balanceLabel
            balanceAmount
        }
        .padding(.horizontal, 24)
    }
    
    var balanceLabel: some View {
        Text("Available Balance")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white.opacity(0.7))
            .textCase(.uppercase)
            .tracking(0.5)
    }
    
    var balanceAmount: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            balanceText
            currencyIndicator
        }
    }
    
    var balanceText: some View {
        if viewModel.isBalanceVisible {
            Text("Balance: 100")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .transition(viewModel.balanceTransition)
        } else {
            Text("••••••")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
                .transition(viewModel.balanceTransition)
        }
    }
    
    var currencyIndicator: some View {
        Text(viewModel.account.currency)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white.opacity(0.7))
            .offset(y: -8)
    }
    
    var accountInfoSection: some View {
        HStack {
            cardNumberInfo
            Spacer()
            cardholderInfo
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
    
    var cardNumberInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("CARD NUMBER")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
                .tracking(0.5)
            
            Text(viewModel.account.accountNumber)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundColor(.white.opacity(0.9))
        }
    }
    
    var cardholderInfo: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text("CARDHOLDER")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
                .tracking(0.5)
            
            Text(viewModel.account.customerName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))
        }
    }
    
}
