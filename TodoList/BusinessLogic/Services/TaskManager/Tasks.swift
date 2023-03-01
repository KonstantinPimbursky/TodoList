//
//  Tasks.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import Foundation

// MARK: - Task

class Task {
    var title: String
    var completed: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

// MARK: - RegularTask

final class RegularTask: Task {}

extension RegularTask: CustomStringConvertible {
    var description: String {
        "- [\(completed ? "x" : " ")] \(title)"
    }
}

// MARK: - ImportantTask

final class ImportantTask: Task {
    enum TaskPriority {
        case low, medium, high
    }
    
    var taskPriority: TaskPriority
    
    private var oneDayTime: TimeInterval = 60*60*24
    
    var deadline: Date {
        switch taskPriority {
        case .low:
            return Date() + oneDayTime
        case .medium:
            return Date() + 2 * oneDayTime
        case .high:
            return Date() + 3 * oneDayTime
        }
    }
    
    init(title: String, taskPriority: TaskPriority) {
        self.taskPriority = taskPriority
        super.init(title: title)
    }
}

extension ImportantTask: CustomStringConvertible {
    var description: String {
        "- [\(completed ? "x" : " ")] Important, priority \(taskPriority): \(title)."
    }
}
