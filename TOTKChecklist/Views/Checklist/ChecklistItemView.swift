import SwiftUI

struct ChecklistItemView: View {
  @EnvironmentObject var modelData: ChecklistModelData
  var item: ChecklistItem
  
  var itemIndex: Int {
    modelData.checklistItems.firstIndex(where: { $0.id == item.id })!
  }
  
  var body: some View {
    VStack {
      Spacer()

      Text(item.location.title)
        .font(.title)
      
      AcquiredButton(isSet: $modelData.checklistItems[itemIndex].acquired)
      
      Spacer()
      
      Text("Location: \(item.location.coordinate.description)")
      
      Text(item.location.description)
      
      Spacer()
    }
  }
}

struct ChecklistItemView_Previews: PreviewProvider {
  static var previews: some View {
    ChecklistItemView(item: ChecklistModelData().checklistItems[0])
      .environmentObject(ChecklistModelData())
  }
}
