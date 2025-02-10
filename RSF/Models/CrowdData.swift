import Foundation

struct CrowdData: Identifiable, Codable {
    var id = UUID()
    var location: String
    var occupancyPercentage: Int
    var lastUpdated: Date
}
