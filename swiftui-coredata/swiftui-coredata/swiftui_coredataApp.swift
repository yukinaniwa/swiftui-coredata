//
//  swiftui_coredataApp.swift
//  swiftui-coredata
//
//  Created by yuki naniwa on 2025/03/13.
//

import SwiftUI

@main
struct swiftui_coredataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
