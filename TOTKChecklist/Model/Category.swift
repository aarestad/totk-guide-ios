import Foundation

class Category: Identifiable, Codable, Hashable {
  init(id: Int, group: Group? = nil, title: String, icon: String, info: String, template: String) {
    self.id = id
    self.group = group
    self.title = try! AttributedString(markdown: title)
    self.icon = icon
    self.info = try! AttributedString(
      markdown: info,
      options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
    )
    self.template = template
  }
  
  
  static func == (lhs: Category, rhs: Category) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var id: Int
  var group: Group?
  var title: AttributedString
  var icon: String
  var info: AttributedString
  var template: String

  static let all: Category = Category.init(id:-1, title:"", icon:"", info:"", template:"")
}
