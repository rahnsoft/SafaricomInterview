//
//  Object+Safaricom.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation
import RealmSwift

extension Object {
    @objc func save(_ update: Bool) {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.add(self, update: update ? .all : .error)
            try realm.commitWrite()
        } catch {}
    }

    func deleteFromRealm() {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.delete(self)
            try realm.commitWrite()
        } catch {}
    }
}
