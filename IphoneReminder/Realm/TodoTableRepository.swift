//
//  TodoModelRepository.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/19/24.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    // 자동완성으로 잘못 호출되지 않게 Private으로 접근 제어
    private let realm = try! Realm()
    
    // C
    func createItem(_ item: TodoModel) {
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
    
    // R
    func fetch() -> Results<TodoModel> {
        return realm.objects(TodoModel.self)
    }
    
    func fetchCompletedCount() -> Int {
        return realm.objects(TodoModel.self).where {
            $0.isCompleted == true
        }.count
    }
    
    func fetchTodayTodoCount() -> Int {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let predicate = NSPredicate(format: "deadLineDate >= %@ AND deadLineDate < %@", argumentArray: [todayStart, todayEnd])
        return realm.objects(TodoModel.self).filter(predicate).count
    }
    
    func fetchScheduleTodoCount() -> Int {
        let now = Date()
        return realm.objects(TodoModel.self).filter("deadLineDate > %@", now).count
    }
    
    func fetchPriorityFilter(_ filter: String) -> Results<TodoModel> {
        return realm.objects(TodoModel.self).where {
            $0.priority == filter
        }.sorted(byKeyPath: "createdAt", ascending: false)
    }
    func sortData(key: String) -> Results<TodoModel> {
        return realm.objects(TodoModel.self)
            .sorted(byKeyPath: key, ascending: true)
    }
    
    // U
    func updateItem(id: ObjectId, title: Int, memo: String?,
                    deadLineDate: Date, tag: String, priority: String) {
        do {
            try realm.write {
                realm.create(TodoModel.self,
                             value: ["id": id,
                                     "title": title,
                                     "deadLineDate": deadLineDate,
                                     "tag": tag,
                                     "priority": priority],
                             update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func updateisCompleted(_ item: TodoModel) {
        do {
            try realm.write {
                item.isCompleted.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    // D
    func deleteItem(_ item: TodoModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
}
