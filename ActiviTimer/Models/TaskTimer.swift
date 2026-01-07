//
//  TaskItem.swift
//  ToDoList
//
//  Created by Jeffrey Zhou on 10/26/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftData

struct TaskTimer : Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let createdDate: TimeInterval
    
    var isActive: Bool
    var startTime: TimeInterval
    var totalTimeSpent: TimeInterval
    
    mutating func start() {
        isActive = true
        startTime = Date().timeIntervalSince1970
        save()
    }
    
    mutating func stop() {
//        guard startTime != nil && isActive else {
//            print("Could not stop task - the task is not active or startTime is nil")
//            return
//        }
//        let now = Date()
//        let timeSpent = now.timeIntervalSince(startTime)
//        totalTimeSpent = totalTimeSpent + timeSpent
        print("About to stop active task:", self)
        let timeSpent = Date().timeIntervalSince1970 - startTime
        print("time spent", timeSpent, Date().timeIntervalSince1970, startTime)
        totalTimeSpent = totalTimeSpent + timeSpent
        isActive = false
        startTime = 0.0
        save()
    }
    
    func save() {
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(id)
            .setData(self.asDictionary())
    }
}

@Model
class TaskTimerV2: Identifiable, CloudSyncable {
    var collection: FirestoreCollectionEnum = FirestoreCollectionEnum.taskTimers
    @Attribute(.unique) var id: String
    var title: String
    var isActive: Bool
    var startTime: TimeInterval
    var createdDate: TimeInterval
    var updatedDate: TimeInterval
    
    init(id: String, title: String, isActive: Bool = false, startTime: TimeInterval = 0, createdDate: TimeInterval = 0, updatedDate: TimeInterval = 0) {
        self.id = id
        self.title = title
        self.isActive = isActive
        self.startTime = startTime
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
    
    // Convert to Firestore-friendly dictionary
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "isActive": isActive,
            "startTime": startTime,
            "createdDate": createdDate,
            "updatedDate": updatedDate,
        ]
    }
    
    // Create TaskTimer from Firestore dictionary
    static func fromDictionary(_ dict: [String: Any]) -> TaskTimerV2? {
        guard
            let id = dict["id"] as? String,
            let title = dict["title"] as? String,
            let isActive = dict["isActive"] as? Bool,
            let startTime = dict["startTime"] as? TimeInterval,
            let createdDate = dict["createdDate"] as? TimeInterval,
            let updatedDate = dict["updatedDate"] as? TimeInterval
        else {
            return nil
        }
        
        return TaskTimerV2(
            id: id,
            title: title,
            isActive: isActive,
            startTime: startTime,
            createdDate: createdDate,
            updatedDate: updatedDate
        )
    }
}
