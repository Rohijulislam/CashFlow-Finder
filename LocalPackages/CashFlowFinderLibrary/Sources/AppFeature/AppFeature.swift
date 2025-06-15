// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Shared
import FilePicker
import Utils

public struct RootView: View {
    @State private var showPicker: Bool = false
    private let filePicker: FilePicker
    
    public init() {
        // Initialization code if needed
        
        filePicker = FilePicker(allowedTypes: [.pdf])
    }
    
    public var body: some View {
        NavigationStack {
            EmptyStateView(showPicker: $showPicker)
                .navigationTitle("Bank Statements")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            showPicker.toggle()
                        } label: {
                            Label("Upload PDF", systemImage: "plus.doc")
                        }
                    }
                }
                .sheet(isPresented: $showPicker) {
                    filePicker.makePickerView { urls in
                        if let url = urls.first {
                            print("Selected file: \(url)")
                            print("text from file: \(PDFTextExtractor().extract(from: url))")
                        }
                    }
                }
        }
        
    }
}
