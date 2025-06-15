//
//  BankAccountView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import SwiftUI

public struct BankAccountView: View {
    let data: String
    
    public init (accountData: String) {
        data = accountData
    }
    
    public var body: some View {
        ScrollView {
            Text(data)
        }
    }
    
}
