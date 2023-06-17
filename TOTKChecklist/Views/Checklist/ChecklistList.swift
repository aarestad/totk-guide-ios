import SwiftUI

struct ChecklistList: View {
  @EnvironmentObject var checklistModelData: ChecklistModelData
  @State private var selectedCategory: Category = .shrine
  
  var filteredItems: [ChecklistItem] {
    checklistModelData.checklistItems.filter { item in
      item.category == selectedCategory
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        Picker("Category", selection: $selectedCategory) {
          ForEach(Category.allCases) {category in
            Text(category.rawValue).tag(category)
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
    ChecklistList()
      .environmentObject(ChecklistModelData())
  }
}

