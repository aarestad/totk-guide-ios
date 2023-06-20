import Foundation

@MainActor
final class ChecklistModelData: ObservableObject {
  @Published var checklistItems: [ChecklistItem] = ChecklistItem.originalData
  
  let mapData = initMapData()
  
  private static func fileURL() throws -> URL {
    try FileManager.default.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
    .appendingPathComponent("checklist_items.data")
  }
  
  func load() async throws {
    let task = Task<[ChecklistItem], Error> {
      let fileURL = try Self.fileURL()
      
      guard let data = try? Data(contentsOf: fileURL) else {
        return ChecklistItem.originalData
      }
      
      return try JSONDecoder().decode([ChecklistItem].self, from: data)
    }
    self.checklistItems = try await task.value
  }
  
  func save() async throws {
    let task = Task {
      let data = try JSONEncoder().encode(checklistItems)
      let outfile = try Self.fileURL()
      try data.write(to: outfile)
    }
    try await task.value
  }
}

func initChecklistItems(mapData: MapData) -> [ChecklistItem] {
  return mapData.locations.map { ChecklistItem(location: $0, acquired: false) }
}
