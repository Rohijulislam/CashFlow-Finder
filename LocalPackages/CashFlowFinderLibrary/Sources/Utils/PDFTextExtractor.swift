//
//  PDFTextExtractor.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/15/25.
//

import Foundation
import PDFKit

public struct PDFTextExtractor {
    
    public init () { }
    
    public func extract(from url: URL) -> Result<String, Error> {
        guard let pdf = PDFDocument(url: url) else {
            return .failure(NSError(domain: "PDFExtractionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to open the document"]))
        }
        
        let text = (0..<pdf.pageCount)
            .compactMap { pdf.page(at: $0)?.string }
            .joined(separator: "\n")
        
        return .success(text)
    }

}
