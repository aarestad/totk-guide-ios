import SwiftUI

@main
struct TOTKChecklistApp: App {
  @StateObject private var modelData = ChecklistModelData()
  
  var body: some Scene {
    WindowGroup {
      ContentView() {
        Task {
          do {
            try await modelData.save()
          } catch {
            fatalError(error.localizedDescription)
          }
        }
      }
      .environmentObject(modelData)
      .task {
        let _ = initMapData()
        
        do {
          try await modelData.load()
        } catch {
          fatalError(error.localizedDescription)
        }
      }
    }
  }
}
