//
//  Coordinator.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import UIKit

final class Coordinator: NSObject, UIDocumentPickerDelegate {
    let onPicked: ([URL]) -> Void
    
    init(onPicked: @escaping ([URL]) -> Void) {
        self.onPicked = onPicked
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        onPicked(urls)
    }
}
