//
//  SwiftDataService.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//
import SwiftUI
import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: TaskTimerV2.self, TaskTimeSegmentV2.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    /// Generic fetch function for any SwiftData model type
    func fetchModels<T: PersistentModel>() -> [T] {
        do {
            return try modelContext.fetch(FetchDescriptor<T>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    // Example usage:
    // let tasks: [TaskTimerV2] = SwiftDataService.shared.fetchModels()
    // let segments: [TaskTimeSegmentV2] = SwiftDataService.shared.fetchModels()
    
    /// Generic function to insert any SwiftData model type
    func addModel<T: PersistentModel>(_ model: T) {
        modelContext.insert(model)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteModel<T: PersistentModel>(_ model: T) {
        modelContext.delete(model)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
