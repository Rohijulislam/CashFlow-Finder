//
//  ViewState.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import Foundation

@MainActor
public enum ViewState<T> {
    case empty
    case loading
    case success(T)
    case error(String)
}

