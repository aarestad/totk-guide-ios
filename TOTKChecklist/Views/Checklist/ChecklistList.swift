import SwiftUI

struct ChecklistList: View {
  @EnvironmentObject var checklistModelData: ChecklistModelData
  
  @State private var selectedCategory: OldCategory = .all
  @State private var selectedRegion: OldRegion = .all
  
  var filteredItems: [Binding<ChecklistItem>] {
    $checklistModelData.checklistItems.filter { $item in
      (selectedCategory == .all || item.category == selectedCategory) && (
        selectedRegion == .all || item.region == selectedRegion)
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        Picker("Category", selection: $selectedCategory) {
          ForEach(OldCategory.allCases) { category in
            Text(category.rawValue).tag(category)
          }
        }
        
        Picker("Region", selection: $selectedRegion) {
          ForEach(OldRegion.allCases) { region in
            Text(region.rawValue).tag(region)
          }
        }
        
        ForEach(filteredItems.sorted{ $0.wrappedValue.name < $1.wrappedValue.name}) { $item in
          ChecklistListItem(item:$item)
        }
      }.navigationTitle("Checklist Items")
    }
  }
}

struct ChecklistList_Previews: PreviewProvider {
  static var previews: some View {
    ChecklistList()
      .environmentObject(ChecklistModelData())
  }
}

