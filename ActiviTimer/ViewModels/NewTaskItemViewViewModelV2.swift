//
//  NewTaskItemViewViewModelV2.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class NewTaskItemViewViewModelV2: ObservableObject {
    @Published var title = ""
    @Published var showAlert = false
    private let datasource: SwiftDataService
    
    init(datasource: SwiftDataService) {
        self.datasource = datasource
    }

    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}
