//
//  ToDoManager_MacOSApp.swift
//  ToDoManager-MacOS
//
//  Created by dan4 on 09.08.2022.
//

import SwiftUI

@main
struct ToDoManager_MacOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
