//
//  CloudSyncable.swift
//  ActiviTimer
//
//  Created by Jeffrey Zhou on 8/10/25.
//

import Foundation

protocol CloudSyncable {
    var id: String { get }
    var collection: FirestoreCollectionEnum { get }
    func toDictionary() -> [String: Any]
}
