//
//  ErrorView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import SwiftUI

public struct ErrorView: View {
    let message: String
    let onRetry: () -> Void

    public init(_ errorMessage: String = "", onRetry: @escaping () -> Void) {
        self.message = errorMessage
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: 12) {
            Text("Error")
                .font(.title2)
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Try Again") {
                onRetry()
            }
            .padding(.top)
        }
        .padding()
    }
}


#Preview {
    ErrorView() {
        
    }
}
