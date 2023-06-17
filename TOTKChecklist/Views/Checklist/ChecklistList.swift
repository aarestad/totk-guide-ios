import SwiftUI

struct ChecklistList: View {
  @EnvironmentObject var checklistModelData: ChecklistModelData
  @State var selectedCategory: Category
  @State var selectedRegion: Region

  var filteredItems: [ChecklistItem] {
    checklistModelData.checklistItems.filter { item in
      (selectedCategory == .all || item.category == selectedCategory) && (
        selectedRegion == .all || item.region == selectedRegion)
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        Picker("Category", selection: $selectedCategory) {
          ForEach(Category.allCases) { category in
            Text(category.rawValue).tag(category)
          }
        }
        
        Picker("Region", selection: $selectedRegion) {
          ForEach(Region.allCases) { region in
            Text(region.rawValue).tag(region)
          }
        }
        
        ForEach(filteredItems.sorted(by:sortByName)) { item in
          ChecklistListItem(item:item)
        }
      }.navigationTitle("Checklist Items")
    }
  }
}

struct ChecklistList_Previews: PreviewProvider {
  static var previews: some View {
    ChecklistList(selectedCategory: .all, selectedRegion: .all)
      .environmentObject(ChecklistModelData())
  }
}

