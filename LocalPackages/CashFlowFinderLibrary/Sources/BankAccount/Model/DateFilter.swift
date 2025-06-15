//
//  DateFilter.swift
//  CashFlowFinderLibrary
//
//  Created by Md. Rohejul Islam on 6/16/25.
//

import Foundation

enum DateFilter: String, CaseIterable {
    case all = "All Time"
    case today = "Today"
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
    case custom = "Custom Range"
    
    var icon: String {
        switch self {
        case .all: return "calendar"
        case .today: return "calendar.circle.fill"
        case .thisWeek: return "calendar.badge.clock"
        case .thisMonth: return "calendar.badge.plus"
        case .thisYear: return "calendar.badge.exclamationmark"
        case .custom: return "calendar.badge.clock"
        }
    }
}
