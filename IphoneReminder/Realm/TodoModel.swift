//
//  TodoModel.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String?
    @Persisted var memo: String?
    @Persisted var deadLineDate: Date?
    @Persisted var createdAt: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var isCompleted: Bool
    @Persisted(originProperty: "todos") var listItem: LinkingObjects<ListItem>
    
    convenience init(title: String?, memo: String? = nil, deadLineDate: Date?, createdAt: Date? = Date(), tag: String?, priority: String?, isCompleted: Bool = false) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadLineDate = deadLineDate
        self.createdAt = createdAt
        self.tag = tag
        self.priority = priority
        self.isCompleted = isCompleted
    }
}

class ListItem: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var colorName: String
    @Persisted var todos: List<TodoModel>
    
    convenience init(title: String, colorName: String) {
        self.init()
        self.title = title
        self.colorName = colorName
    }
}
