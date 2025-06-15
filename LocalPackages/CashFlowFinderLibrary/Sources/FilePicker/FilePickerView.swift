//
//  FilePickerView.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct FilePickerView: UIViewControllerRepresentable {
    typealias DocumentTypes = [UTType]
    
    private let allowedTypes: DocumentTypes
    private let allowsMultipleSelection: Bool
    private let onPicked: ([URL]) -> Void
    
    init(
        allowedTypes: DocumentTypes = [.item],
        allowsMultipleSelection: Bool = false,
        onPicked: @escaping ([URL]) -> Void
    ) {
        self.allowedTypes = allowedTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.onPicked = onPicked
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onPicked: onPicked)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: allowedTypes, asCopy: true)
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = allowsMultipleSelection
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
