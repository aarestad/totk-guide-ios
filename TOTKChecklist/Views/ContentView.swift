import SwiftUI

struct ContentView: View {
  var body: some View {
    ChecklistList(selectedCategory: .all, selectedRegion: .all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(ChecklistModelData())
  }
}
