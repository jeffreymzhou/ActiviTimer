//
//  TimeSegment.swift
//  ToDoList
//
//  Created by Jeffrey Zhou on 11/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftData

struct TaskTimeSegment : Codable, Identifiable, Equatable {
    let id: String
    let start: TimeInterval
    let end: TimeInterval
    let parentTaskId: String
    
    func save() {
        print("save time segment", self.asDictionary())
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            print("not logged in, skipping")
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("segments")
            .document(id)
            .setData(self.asDictionary()) { error in
                if let error = error {
                    print("Error setting data: \(error.localizedDescription)")
                } else {
                    print("Data successfully written!")
                }
            }
    }
}


@Model
class TaskTimeSegmentV2: Identifiable, CloudSyncable {
    var collection: FirestoreCollectionEnum = FirestoreCollectionEnum.timeSegments
    var id: String
    var start: TimeInterval
    var end: TimeInterval
    var parentTaskId: String

    init(id: String, start: TimeInterval, end: TimeInterval, parentTaskId: String) {
        self.id = id
        self.start = start
        self.end = end
        self.parentTaskId = parentTaskId
    }

    // Convert to Firestore-friendly dictionary
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "start": start,
            "end": end,
            "parentTaskId": parentTaskId
        ]
    }

    // Create TaskTimeSegmentV2 from Firestore dictionary
    static func fromDictionary(_ dict: [String: Any]) -> TaskTimeSegmentV2? {
        guard
            let id = dict["id"] as? String,
            let start = dict["start"] as? TimeInterval,
            let end = dict["end"] as? TimeInterval,
            let parentTaskId = dict["parentTaskId"] as? String
        else {
            print("Failed to parse TaskTimeSegmentV2 from dictionary: \(dict)")
            return nil
        }
        return TaskTimeSegmentV2(id: id, start: start, end: end, parentTaskId: parentTaskId)
    }
}
