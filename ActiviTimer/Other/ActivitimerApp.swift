//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Jeffrey Zhou on 3/30/24.
//

import FirebaseCore
import SwiftUI
import SwiftData

@main
struct ActivitimerApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: TaskTimerV2.self)
    }
}
