// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Shared

public struct RootView: View {
    public init() {
        // Initialization code if needed
    }
    
    public var body: some View {
        EmptyStateView(showPicker: .constant(true))
    }
}
