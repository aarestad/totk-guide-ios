import Foundation

class Region: Identifiable, Codable {
  var id: Int
  var parentRegion: Region?
  var title: String
}
