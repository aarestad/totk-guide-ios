import SwiftUI

struct ChecklistListItem: View {
  var item: ChecklistItem
  
    var body: some View {
      HStack{
        Label("Acquired", systemImage: item.acquired ? "checkmark.circle.fill" : "checkmark.circle")
          .foregroundColor(item.acquired ? .yellow : .gray)
          .labelStyle(.iconOnly)
        
        NavigationLink {
          ChecklistItemView(item: item)
        } label: {
          Text(item.name)
        }
      }.onLongPressGesture(perform: {
//        item.acquired.toggle()
      })
    }
}

struct ChecklistListItem_Previews: PreviewProvider {
  static let item = ChecklistModelData().checklistItems[0]
  
    static var previews: some View {
      ChecklistListItem(item: item)
    }
}
