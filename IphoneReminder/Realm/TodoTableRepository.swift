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
    func createItem(_ item: TodoModel, listItem: ListItem?) {
        print(realm.configuration.fileURL)
        
        do {
            try realm.write {
                if let listItem {
                    listItem.todos.append(item)
                }
                realm.add(item)
                print("Realm Create")
            }
        } catch {
            print(error)
        }
    }
    
    // R
    // Total
    func fetch() -> Results<TodoModel> {
        return realm.objects(TodoModel.self)
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
    
    // Completed
    func fetchCompleted() -> Results<TodoModel> {
        return realm.objects(TodoModel.self).where {
            $0.isCompleted == true
        }
    }
    func fetchCompletedPriorityFilter(_ filter: String) -> Results<TodoModel> {
        return realm.objects(TodoModel.self).where {
            $0.isCompleted == true && $0.priority == filter
        }.sorted(byKeyPath: "createdAt", ascending: false)
    }
    func fetchCompletedSortData(key: String) -> Results<TodoModel> {
        return realm.objects(TodoModel.self).where {
            $0.isCompleted == true
        }.sorted(byKeyPath: key, ascending: true)
    }
    
    
    // Today
    func fetchTodayTodo() -> Results<TodoModel> {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let predicate = NSPredicate(format: "deadLineDate >= %@ AND deadLineDate < %@", argumentArray: [todayStart, todayEnd])
        return realm.objects(TodoModel.self).filter(predicate)
    }
    func fetchTodayPriorityFilter(_ filter: String) -> Results<TodoModel> {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let predicate = NSPredicate(format: "deadLineDate >= %@ AND deadLineDate < %@", argumentArray: [todayStart, todayEnd])
        
        return realm.objects(TodoModel.self).filter(predicate).where {
            $0.priority == filter
        }.sorted(byKeyPath: "createdAt", ascending: false)
    }
    func fetchTodaySortData(key: String) -> Results<TodoModel> {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let predicate = NSPredicate(format: "deadLineDate >= %@ AND deadLineDate < %@", argumentArray: [todayStart, todayEnd])
        return realm.objects(TodoModel.self).filter(predicate).sorted(byKeyPath: key, ascending: true)
    }
    
    // Schedule
    func fetchScheduleTodo() -> Results<TodoModel> {
        let now = Date()
        return realm.objects(TodoModel.self).filter("deadLineDate > %@", now)
    }
    func fetchSchedulePriorityFilter(_ filter: String) -> Results<TodoModel> {
        let now = Date()
        return realm.objects(TodoModel.self).filter("deadLineDate > %@", now).where {
            $0.priority == filter
        }.sorted(byKeyPath: "createdAt", ascending: false)
    }
    func fetchScheduleSortData(key: String) -> Results<TodoModel> {
        let now = Date()
        return realm.objects(TodoModel.self).filter("deadLineDate > %@", now)
            .sorted(byKeyPath: key, ascending: true)
    }
    
    // U
    func updateItem(todoModel: TodoModel, listItem: ListItem?) {
        if let title = todoModel.title, let deadLineDate = todoModel.deadLineDate, let tag = todoModel.tag, let priority = todoModel.priority {
            print("\(listItem)있냐????")
            print("\(todoModel.listItem.first)있냐고;;;;")
            do {
                try realm.write {
                    realm.create(TodoModel.self,
                                 value: ["id": todoModel.id,
                                         "title": title,
                                         "memo": todoModel.memo ?? nil,
                                         "deadLineDate": deadLineDate,
                                         "tag": tag,
                                         "priority": priority],
                                 update: .modified)
                    print("todoModel 정상")
                    if let todo = realm.object(ofType: TodoModel.self, forPrimaryKey: todoModel.id) {
                        print("todo 있음")
                        if let currentListItem = todo.listItem.first {
                            print("currentListItem 있음")
                            if listItem != nil {
                                print("listItem 있음")
                                if let index = currentListItem.todos.firstIndex(where: { $0.id == todo.id }) {
                                    print("삭제할 인덱스 찾음")
                                    currentListItem.todos.remove(at: index)
                                    listItem!.todos.append(todo)
                                    
                                }
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
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
