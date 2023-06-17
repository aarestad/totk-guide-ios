import SwiftUI

struct ChecklistItemView: View {
  @EnvironmentObject var modelData: ChecklistModelData
  var item: ChecklistItem
  
  var landmarkIndex: Int {
    modelData.checklistItems.firstIndex(where: { $0.id == item.id })!
  }
  
  var body: some View {
    VStack {
      Spacer()

      Text(item.name)
        .font(.title)
      
      AcquiredButton(isSet: $modelData.checklistItems[landmarkIndex].acquired)
      
      Spacer()
      
      if let loc = item.location {
        Text("Location: \(loc.description)")
      }
      
      Text(item.info.stripOutHtml())
      
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
