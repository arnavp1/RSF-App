//
//  CrowdViewModel.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import Foundation
import Combine

class CrowdViewModel: ObservableObject {
    @Published var crowdData: [CrowdData] = []
    
    init() {
        fetchMockCrowdData()
    }
    
    func fetchMockCrowdData() {
        // Mock data simulating an API response
        crowdData = [
            CrowdData(location: "Weight Room", occupancyPercentage: 75, lastUpdated: Date()),
            CrowdData(location: "CMS Fitness", occupancyPercentage: 50, lastUpdated: Date()),
        ]
    }
}
