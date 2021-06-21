//
//  TrendsApp.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI

@main
struct TrendsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
