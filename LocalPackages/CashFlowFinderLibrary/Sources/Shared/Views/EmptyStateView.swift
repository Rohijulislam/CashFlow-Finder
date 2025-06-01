//
//  EmptyStateView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/1/25.
//

import SwiftUI

public struct EmptyStateView: View {
    @Binding public var showPicker: Bool 
    
    // Add this public initializer
        public init(showPicker: Binding<Bool>) {
            self._showPicker = showPicker
        }
    
    public var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 80))
                .foregroundColor(.gray.opacity(0.5))
            
            VStack(spacing: 12) {
                Text("No Bank Statements")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Upload a PDF bank statement to start analyzing your transactions")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button {
                showPicker.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.doc")
                    Text("Upload PDF Statement")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(12)
            }
            
        }
    }
}

#Preview {
    EmptyStateView(showPicker: .constant(true))
}
