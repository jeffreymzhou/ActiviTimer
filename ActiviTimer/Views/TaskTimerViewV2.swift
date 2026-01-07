//
//  TaskTimerViewV2.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation
import SwiftUI

struct TaskTimerViewV2: View {
    let switchTaskCallback: (TaskTimerV2) -> Void
    @Binding var activeTask: TaskTimerV2?
    @Binding var elapsedTimeSeconds: TimeInterval
    @StateObject var viewModel = TaskTimerViewViewModelV2()
    let task: TaskTimerV2
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.body)
                    .bold()
                if task.id == activeTask?.id {
                    Text("Task has started: " + formatTimeInterval(elapsedTimeSeconds))
                }
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            Button {
                switchTaskCallback(task)
            } label : {
                Image(systemName: task.isActive ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

//#Preview {
//    TaskTimerView(
//        switchTaskCallback: {task in
//            // Define what should happen when switchTask is called
//            print("Switch task function called with task: \(task)")
//        },
//        activeTask: .constant(nil), // Use .constant for Binding in previews
//        elapsedTimeSeconds: .constant(0),
//        task: TaskTimer(
//            id: "123",
//            title: "Get milk",
//            createdDate: Date().timeIntervalSince1970,
//            isActive: true,
//            startTime: 0,
//            totalTimeSpent: 100
//        )
//    )
//}
