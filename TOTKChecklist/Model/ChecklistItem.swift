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

// regions: {'Lanayru Great Spring', 'Mount Lanayru', 'Sky', 'Eldin Mountains', 'Great Sky Island', 'Gerudo Highlands', 'Faron Grasslands', 'Depths', 'Hyrule Field', 'Hyrule Ridge', 'Gerudo Desert', 'Eldin Canyon', 'Tabantha Frontier', 'East Necluda', 'Akkala Highlands', 'West Necluda', 'Hyrule Castle', 'Lanayru Wetlands', 'Deep Akkala', 'Great Hyrule Forest', 'Lightning Temple', 'Hebra Mountains'}

enum Category: String, CaseIterable, Codable, Identifiable {
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

func sortByName(lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
  return lhs.name < rhs.name
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
  var region: String
  var info: String
  var location: Coordinate?
  var acquired: Bool
}
