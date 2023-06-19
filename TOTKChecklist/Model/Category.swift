import Foundation

struct Category: Identifiable, Codable, Hashable {
  static func == (lhs: Category, rhs: Category) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var id: Int
  var group: Group?
  var title: String
  var icon: String
  var info: String
  var template: String
  
  static let all: Category = try! JSONDecoder().decode(Category.self, from: """
{
  "id": -1,
  "title": "**All**",
  "icon": "",
  "info": "",
  "template": ""
}
""".data(using: .utf8)!)
}
