//
//  File.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import Foundation
import Shared
import Utils
import FilePicker


@MainActor
final class RootViewModel<T>: ObservableObject {
    @Published var viewState: ViewState<T> = .empty
    @Published var showPicker = false
    
    let filePicker: FilePicker = FilePicker(allowedTypes: [.pdf])
    
    func processSelectedFiles(_ files: [URL]) {
        print("Selected files: \(files)")
        
        guard files.count == 1, let file = files.first else {
            if files.isEmpty {
                viewState = .empty
            } else {
                viewState = .error("Multiple file selection is not supported yet")
            }
            return
        }
        
        let extractionResult = PDFTextExtractor().extract(from: file)
        
        switch extractionResult {
        case .success(let text):
            // We can only assign if T == String, otherwise error
            if T.self == String.self {
                // Force cast is safe here because we checked T
                viewState = .success(text as! T)
            } else {
                viewState = .error("Unsupported type for extracted data")
            }
            
        case .failure(let error):
            viewState = .error(error.localizedDescription)
        }
    }
}

