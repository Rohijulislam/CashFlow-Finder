//
//  BankAccountView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//
import SwiftUI

public struct BankAccountView: View {
    private let accountData: String
    @StateObject private var viewModel = BankAccountViewModel()

    public init(accountData: String) {
        self.accountData = accountData
    }

    public var body: some View {
        content
            .onAppear {
                viewModel.parseTransactions(from: accountData)
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            loadingView
        case .error(let message):
            errorView(message: message)
        case .empty:
            emptyView
        case .success(let transactions):
            transactionsList(transactions)
        }
    }

    private var loadingView: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .scaleEffect(1.5)

                Text("Parsing your data...")
                    .font(.body.weight(.medium))
                    .foregroundColor(.primary.opacity(0.8))
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 6)
            )
            .padding(.horizontal, 40)
        }
        .transition(.opacity.combined(with: .scale))
    }


    private func errorView(message: String) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.red)
                .font(.largeTitle)
            Text("Error")
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }

    private var emptyView: some View {
        VStack {
            Image(systemName: "tray")
                .foregroundColor(.gray)
                .font(.largeTitle)
            Text("No Transactions")
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }

    private func transactionsList(_ transactions: [BankTransaction]) -> some View {
        List(transactions) { transaction in
            HStack {
                Text(transaction.description)
                    .font(.subheadline)
                Spacer()
                Text("\(transaction.amount)")
            }
            .padding(.vertical, 4)
        }
        .listStyle(.plain)
    }
}
