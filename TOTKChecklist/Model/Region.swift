import Foundation

class Region: Identifiable, Codable, Hashable {
  static func == (lhs: Region, rhs: Region) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var id: Int
  var parentRegion: Region?
  var title: String
  
  static let all: Region = try! JSONDecoder().decode(Region.self, from: "{\"id\": -1, \"title\": \"**All**\"}".data(using: .utf8)!)
}
