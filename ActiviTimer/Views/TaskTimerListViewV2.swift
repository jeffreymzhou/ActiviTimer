//
//  TaskTimerListViewV2.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import SwiftUI
import SwiftData // or your framework providing ModelContext

struct TaskTimersListViewV2: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: TaskTimerListViewViewModelV2 = TaskTimerListViewViewModelV2(datasource: .shared)

    init() {}
//
//    var body: some View {
//        NavigationView {
//            List() {
//                ForEach(viewModel.tasks) { task in
//                    Text(task.title)
//                }
////                VStack(alignment: .leading) {
////                    Text(timer.title)
////                        .font(.headline)
////                    Text(timer.collection.rawValue)
////                        .font(.subheadline)
////                        .foregroundColor(.secondary)
////                }
//            }
//            .navigationTitle("Tasks (local storage)")
//        }
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.tasks) { task in
                    TaskTimerViewV2(
                                switchTaskCallback: { task in
                                    viewModel.switchTask(newTask: task)
                                    // Define what should happen when switchTask is called
                                    print("Switch task function called")
                                },
                                activeTask: $viewModel.activeTask,
                                elapsedTimeSeconds: $viewModel.elapsedTimeSeconds,
                                task: task // Provide an instance of TaskTimer
                            )
                        .swipeActions {
                            Button("Delete") {
                                print("delete")
                            }
                            .tint(.red)
                        }
                }

            }
            .navigationTitle("Tasks")
            .toolbar {
                Button {
                    viewModel.showingNewTaskTimerView = true
                } label : {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewTaskTimerView) {
                NewTaskItemViewV2(visible: $viewModel.showingNewTaskTimerView, saveLocalCallback:  viewModel.saveTaskLocal)
            }
        }
    }
}
