import Foundation

struct Category: Identifiable, Codable {
  var id: Int
  var group: Group
  var title: String
  var icon: String
  var info: String
  var template: String 
}
