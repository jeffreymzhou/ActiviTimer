//
//  NewTaskItemViewV2.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import SwiftUI

struct NewTaskItemViewV2: View {
    @StateObject var viewModel = NewTaskItemViewViewModelV2(datasource: .shared)
    @Binding var visible: Bool
    let saveLocalCallback: (TaskTimerV2) -> Void
    
    var body: some View {
        VStack {
            Text("New Task (local)")
                .font(.system(size:32))
                .bold()
                .padding(.top, 100)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)

                // Button
                TLButton(title: "Save",
                         background: .pink) {
                    if viewModel.canSave {
                        let newTask = TaskTimerV2(
                            id: UUID().uuidString,
                            title: viewModel.title,
                            isActive: false,
                            startTime: Date().timeIntervalSince1970,
                            createdDate: Date().timeIntervalSince1970,
                            updatedDate: Date().timeIntervalSince1970,
                        )
                            
                        saveLocalCallback(newTask)
                        visible = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select due date that is today or newer."))
            }
        }
    }
}

//struct NewTaskItemViewV2_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskItemViewV2(visible: Binding(get: {
//            return true
//        }, set: {_ in
//            
//        }))
//    }
//}
