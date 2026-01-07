//
//  TaskTimerViewViewModelV2.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TaskTimerViewViewModelV2: ObservableObject {
    @Published var currentTimeSpent: TimeInterval = 0
    var timer = Timer()
    var startTime: Date? = nil
    @Published var elapsedTimeSeconds: TimeInterval = 0
    
    init() {}
}
