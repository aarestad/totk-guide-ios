import SwiftUI

struct ChecklistList: View {
  @EnvironmentObject var checklistModelData: ChecklistModelData
  
  @State private var selectedCategory: Category = .all
  @State private var selectedRegion: Region = .all
  
  var filteredItems: [Binding<ChecklistItem>] {
    $checklistModelData.checklistItems.filter { $item in
      (selectedCategory == .all || $item.location.wrappedValue.category == selectedCategory) && (
        selectedRegion == .all || $item.location.wrappedValue.region == selectedRegion)
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        Picker("Category", selection: $selectedCategory) {
          ForEach(checklistModelData.mapData.categories) { category in
            Text(try! AttributedString(markdown: category.title)).tag(category)
          }
        }
        
        Picker("Region", selection: $selectedRegion) {
          ForEach(checklistModelData.mapData.regions) { region in
            Text(try! AttributedString(markdown: region.title)).tag(region)
          }
        }
        
        ForEach(filteredItems) { item in
          ChecklistListItem(item:item)
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

