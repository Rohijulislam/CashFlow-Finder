//
//  FilePicker.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import SwiftUI
import UniformTypeIdentifiers

public struct FilePicker {
    private let allowedTypes: [UTType]
    private let allowsMultipleSelection: Bool
    
    public init(allowedTypes: [UTType], allowsMultipleSelection: Bool = false) {
        self.allowedTypes = allowedTypes
        self.allowsMultipleSelection = allowsMultipleSelection
    }
    
    @MainActor @ViewBuilder
    public func makePickerView(onPicked: @escaping ([URL]) -> Void) -> some View {
        FilePickerView(allowedTypes: allowedTypes, allowsMultipleSelection: allowsMultipleSelection, onPicked: onPicked)
    }

}
