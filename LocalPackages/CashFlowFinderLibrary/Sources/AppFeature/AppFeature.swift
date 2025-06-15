// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Shared
import FilePicker
import Utils
import BankAccount

public struct RootView: View {
    @StateObject private var viewModel = RootViewModel<String>()
    
    public init() {
        // Initialization code if needed
    }
    
    public var body: some View {
        NavigationStack {
            content
                .navigationTitle("Bank Statements")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showPicker.toggle()
                        } label: {
                            Label("Upload PDF", systemImage: "plus.doc")
                        }
                    }
                }
                .sheet(isPresented: $viewModel.showPicker) {
                    viewModel.filePicker.makePickerView { urls in
                        viewModel.processSelectedFiles(urls)
                    }
                }
        }
        
    }
    
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .empty:
            EmptyStateView(showPicker: $viewModel.showPicker)
        case .loading:
            ProgressView("Processing...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .success(let result):
            BankAccountView(accountData: result)
        case .error(let message):
            ErrorView(message) {
                viewModel.viewState = .empty
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
}
