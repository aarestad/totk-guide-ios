import SwiftUI

struct ChecklistListItem: View {
  @Binding var item: ChecklistItem
  static private var impactMed = UIImpactFeedbackGenerator(style: .medium)
  
    var body: some View {
      HStack{
        Label("Acquired", systemImage: item.acquired ? "checkmark.circle.fill" : "checkmark.circle")
          .foregroundColor(item.acquired ? .yellow : .gray)
          .labelStyle(.iconOnly)
        
        NavigationLink {
          ChecklistItemView(item: item)
        } label: {
          Text(item.location.title)
        }
      }.onLongPressGesture(perform: {
        item.acquired.toggle()
        ChecklistListItem.impactMed.impactOccurred()
      })
    }
}

struct ChecklistListItem_Previews: PreviewProvider {
  static let item = ChecklistModelData().checklistItems[0]
  
    static var previews: some View {
      ChecklistListItem(item: .constant(item))
    }
}
