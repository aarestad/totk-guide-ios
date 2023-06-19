import Foundation

struct Location: Identifiable, Codable {
  var id: Int
  var region: Region
  var category: Category
  var title: String
  var description: AttributedString
  var latitude: Double
  var longitude: Double
  var media: [Media]
}
