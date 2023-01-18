//
//  RealmMigrator.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import Foundation
import RealmSwift

struct RealmMigrator {
    static var configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
}
