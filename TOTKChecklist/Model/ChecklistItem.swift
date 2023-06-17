import Foundation

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
  case dragonTear = "Dragon Tear"
  case armor = "Armor"
  case memory = "Memory"
  case shrine = "Shrine"
  case sideQuest = "Side Quest"
  case greatFairy = "Great Fairy"
  case paragliderFabric = "Paraglider Fabric"
  case schemaStone = "Schema Stone"
  case cave = "Cave"
  case yigaSchematic = "Yiga Schematic"
  case korokSeed = "Korok Seed"
  case well = "Well"
  case techLab = "Tech Lab"
  case landmark = "Landmark"
  case shrineQuest = "Shrine Quest"
  case sideAdventure = "Side Adventure"
  case sagesWill = "Sage's Will"
  case mainQuest = "Main Quest"
  case hudsonSign = "Hudson Sign"
  case temple = "Temple"
  case lightroot = "Lightroot"
  
  var id: Self { self }
}

enum Region: String, CaseIterable, Codable, Identifiable {
  case all = "All"
  case lgs = "Lanayru Great Spring"
  case ml = "Mount Lanayru"
  case sky = "Sky"
  case em = "Eldin Mountains"
  case gsi = "Great Sky Island"
  case gh = "Gerudo Highlands"
  case fg = "Faron Grasslands"
  case depths = "Depths"
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

func sortByName(lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
  return lhs.name < rhs.name
}
