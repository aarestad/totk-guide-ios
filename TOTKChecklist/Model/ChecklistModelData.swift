import Foundation

@MainActor
final class ChecklistModelData: ObservableObject {
  @Published var checklistItems: [ChecklistItem] = ChecklistItem.sampleData
  
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
        return initChecklistItems()
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

func initChecklistItems<T: Decodable>() -> T {
  let filename = "checklist_items_init.json"
  let data: Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError("Couldn't find \(filename) in main bundle.")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
  }
  
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
  }
}

