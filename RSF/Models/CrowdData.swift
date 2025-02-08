//
//  CrowdData.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import Foundation

struct CrowdData: Identifiable, Codable {
    var id = UUID()
    var location: String
    var occupancyPercentage: Int
    var lastUpdated: Date
}
