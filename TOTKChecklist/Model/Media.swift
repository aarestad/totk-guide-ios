import Foundation

struct Media: Identifiable, Codable {
  var id: Int
  var url: URL
  var type: String
  var mimeType: String?
}
