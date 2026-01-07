//
//  TaskTimerListViewV2ViewModel.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import SwiftData

class TaskTimerListViewViewModelV2: ObservableObject {
    @Published var showingNewTaskTimerView = false;
    @Published var tasks: [TaskTimerV2] = []
    @Published var activeTask: TaskTimerV2?
    @Published var elapsedTimeSeconds: TimeInterval = 0
    
    private let datasource: SwiftDataService
    
    init(datasource: SwiftDataService) {
        self.datasource = datasource
 
        tasks = datasource.fetchModels()
    }
    
    func saveTaskLocal(task: TaskTimerV2) {
        print("saving new task \(task.title) to local SwiftData context (callback called)")
        self.datasource.addModel(task)
        tasks = self.datasource.fetchModels()
    }
    
    func switchTask(newTask: TaskTimerV2) {
        print("trying to switch task")
    }
//
//    func switchTask(newTask: TaskTimerV2) {
//        // Determine whether the start a new task based on if the newly requested task
//        // is equal to the currently active task or not
//        let startNewTask = (newTask.id != activeTask?.id)
//        print("Switching task ", newTask.title)
//        print("Start new task bool: " + startNewTask.description)
//        
//        if var activeTask = activeTask {
//            print("Stopping: \(activeTask.title)")
//            let newTimeSegment = TaskTimeSegmentV2(
//                id: UUID().uuidString,
//                start: activeTask.startTime,
//                end: Date().timeIntervalSince1970,
//                parentTaskId: activeTask.id
//            )
//            datasource.
//            newTimeSegment.save()
////            resetTimer()
//            
//            self.activeTask = nil
//        }
//
//        if startNewTask {
//            var newTaskCopy = newTask
//            newTaskCopy.start()
//            startTimer()
//            
//            activeTask = newTaskCopy
//        }
//    }
    
    
}
    
extension TaskTimerV2 {
    static let dummyTasks: [TaskTimerV2] = [
        TaskTimerV2(
            id: UUID().uuidString,
            title: "Task 1",
            isActive: false,
            createdDate: Date().timeIntervalSince1970,
            updatedDate: Date().timeIntervalSince1970,
        )
    ]
}
