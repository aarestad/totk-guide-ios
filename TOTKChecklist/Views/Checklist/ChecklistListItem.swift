//
//  ChecklistListItem.swift
//  TOTKChecklist
//
//  Created by Peter Aarestad on 6/16/23.
//

import SwiftUI

struct ChecklistListItem: View {
  var item: ChecklistItem
  @EnvironmentObject var checklistModelData: ChecklistModelData
  
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
      }
    }
}

struct ChecklistListItem_Previews: PreviewProvider {
  static let modelData = ChecklistModelData()
  
    static var previews: some View {
      ChecklistListItem(item: modelData.checklistItems[0])
        .environmentObject(modelData)
    }
}
