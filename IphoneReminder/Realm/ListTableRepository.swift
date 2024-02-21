//
//  ListTableRepository.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/21/24.
//

import Foundation
import RealmSwift

final class ListTableRepository {
    private let realm = try! Realm()
    
    // C
    func createItem(_ item: ListItem) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create")
            }
        } catch {
            print(error)
        }
    }
    
    // Total
    func fetch() -> Results<ListItem> {
        return realm.objects(ListItem.self)
    }
}
