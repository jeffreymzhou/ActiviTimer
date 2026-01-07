//
//  CloudSyncManager.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation
import SwiftData
import FirebaseFirestore
import Network

class SyncManager {
    static let shared = SyncManager()
    
    private var pendingQueue: [CloudSyncable] = []
    private let monitor = NWPathMonitor()
    private let db = Firestore.firestore()
    private var isOnline: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isOnline = path.status == .satisfied
            if self.isOnline {
//                self.flushQueue()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
//    func syncTask(_ task: TaskTimer) {
//        if isOnline {
//            pushToFirestore(task)
//        } else {
//            print("Offline — queueing task for later sync: \(task.title)")
//            pendingQueue.append(task)
//        }
//    }
    
//    private func flushQueue() {
//        guard !pendingQueue.isEmpty else { return }
//        print("Online again — syncing queued tasks...")
//        let tasksToSync = pendingQueue
//        pendingQueue.removeAll()
//        for task in tasksToSync {
//            pushToFirestore(task)
//        }
//    }
    
    private func pushToFirestore(_ item: any CloudSyncable) {
        let collection = "test-sync-collection"
            db.collection(collection)
                .document(item.id)
                .setData(item.toDictionary()) { error in
                    if let error = error {
                        print("Error syncing \(collection) to Firestore: \(error)")
                        self.pendingQueue.append(item) // Re-queue if sync fails
                    } else {
                        print("✅ \(collection) synced successfully to Firestore: \(item.id)")
                    }
                }
        }
}
