import Foundation
import SwiftUI

struct Coordinate: Hashable, Codable {
  var x: Int
  var y: Int
  var z: Int
}

extension Coordinate: CustomStringConvertible {
  var description: String {
    "(\(x), \(y), \(z))"
  }
}

enum Category: String, CaseIterable, Codable, Identifiable {
  case all = "All"
  case dt = "Dragon Tear"
  case a = "Armor"
  case m = "Memory"
  case s = "Shrine"
  case sq = "Side Quest"
  case gf = "Great Fairy"
  case pf = "Paraglider Fabric"
  case ss = "Schema Stone"
  case c = "Cave"
  case ys = "Yiga Schematic"
  case ks = "Korok Seed"
  case w = "Well"
  case tl = "Tech Lab"
  case l = "Landmark"
  case shQ = "Shrine Quest"
  case sa = "Side Adventure"
  case sw = "Sage's Will"
  case mq = "Main Quest"
  case hs = "Hudson Sign"
  case t = "Temple"
  case lr = "Lightroot"
  
  var id: Self { self }
}

enum Region: String, CaseIterable, Codable, Identifiable {
  case all = "All"
  case lgs = "Lanayru Great Spring"
  case ml = "Mount Lanayru"
  case s = "Sky"
  case em = "Eldin Mountains"
  case gsi = "Great Sky Island"
  case gh = "Gerudo Highlands"
  case fg = "Faron Grasslands"
  case d = "Depths"
  case hf = "Hyrule Field"
  case hr = "Hyrule Ridge"
  case gd = "Gerudo Desert"
  case ec = "Eldin Canyon"
  case tf = "Tabantha Frontier"
  case en = "East Necluda"
  case ah = "Akkala Highlands"
  case wn = "West Necluda"
  case hc = "Hyrule Castle"
  case lw = "Lanayru Wetlands"
  case da = "Deep Akkala"
  case ghf = "Great Hyrule Forest"
  case lt = "Lightning Temple"
  case hm = "Hebra Mountains"
  
  var id: Self { self }
}

extension String {
  func stripOutHtml() -> String {
    do {
      guard let data = self.data(using: .unicode) else {
        return ""
      }
      let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
      return attributed.string
    } catch {
      return ""
    }
  }
}

struct ChecklistItem: Hashable, Codable, Identifiable {
  var id: Int
  var name: String
  var category: Category
  var region: Region
  var info: String
  var location: Coordinate?
  var acquired: Bool
}

func sortByName(lhs: Binding<ChecklistItem>, rhs: Binding<ChecklistItem>) -> Bool {
  return lhs.wrappedValue.name < rhs.wrappedValue.name
}

extension ChecklistItem {
  static let sampleData: [ChecklistItem] = initChecklistItems()
}
