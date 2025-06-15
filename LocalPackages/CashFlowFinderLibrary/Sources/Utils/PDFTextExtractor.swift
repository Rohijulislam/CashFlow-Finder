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
    
    public func extract(from url: URL) -> String {
        guard let pdf = PDFDocument(url: url) else { return "" }
        return (0..<pdf.pageCount).compactMap { pdf.page(at: $0)?.string }.joined(separator: "\n")
    }
}
