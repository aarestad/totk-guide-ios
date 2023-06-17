import SwiftUI

struct ContentView: View {
  @Environment(\.scenePhase) private var scenePhase
  let saveAction: ()->Void
  
  var body: some View {
    ChecklistList(selectedCategory: .all, selectedRegion: .all)
      .onChange(of: scenePhase) { phase in
        if phase == .inactive { saveAction() }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(saveAction: {})
      .environmentObject(ChecklistModelData())
  }
}
