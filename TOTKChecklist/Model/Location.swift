import Foundation

struct Coordinate: Hashable, Codable, CustomStringConvertible {
  var description: String {
    "(\(lng), \(lat))"
  }
  
  var lng: Double
  var lat: Double
}

class Location: Identifiable, Codable {
  init(
    id: Int,
    region: Region,
    category: Category,
    title: String,
    description: String,
    latitude: Double,
    longitude: Double,
    media: [Media]
  ) {
    self.id = id
    self.region = region
    self.category = category
    self.title = try! AttributedString(markdown: title)
    self.description = try! AttributedString(
      markdown: description,
      options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
    )
    self.coordinate = Coordinate(lng:latitude, lat:longitude)
    self.media = media
  }
  
  var id: Int
  var region: Region
  var category: Category
  var title: AttributedString
  var description: AttributedString
  var coordinate: Coordinate
  var media: [Media]
}
