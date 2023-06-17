//
//  TOTKChecklistApp.swift
//  TOTKChecklist
//
//  Created by Peter Aarestad on 6/16/23.
//

import SwiftUI

@main
struct TOTKChecklistApp: App {
  @StateObject private var modelData = ChecklistModelData()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(modelData)
    }
  }
}
