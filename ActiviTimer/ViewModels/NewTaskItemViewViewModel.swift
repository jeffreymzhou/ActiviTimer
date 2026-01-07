//
//  NewTaskItemView.swift
//  ToDoList
//
//  Created by Jeffrey Zhou on 10/26/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class NewTaskItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var showAlert = false
    
//    @Environment(\.modelContext) private var context
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newId = UUID().uuidString
        let newItem = TaskTimer(
            id: newId,
            title: title,
            createdDate: Date().timeIntervalSince1970,
            isActive: false,
            startTime: Date().timeIntervalSince1970,
            totalTimeSpent: 0
        )
        
        // Save model to db
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(newId)
            .setData(newItem.asDictionary())
        
    }
//    
//    func saveLocal() {
//        print("saving new task \(title) to local SwiftData context")
//        var newTaskTimer = TaskTimerV2(
//            id: UUID().uuidString,
//            title: title,
//            isActive: false,
//            createdDate: Date().timeIntervalSince1970,
//            updatedDate: Date().timeIntervalSince1970)
//        context.insert(newTaskTimer)
//    }
//    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}
