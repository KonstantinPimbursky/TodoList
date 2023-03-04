//
//  Tasks.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import Foundation

// MARK: - Task

/// Задача для списка задач.
class Task {
	/// Текст задачи.
    var title: String
	
	/// Флаг завершена задача или нет.
    var completed: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

// MARK: - RegularTask

/// Обычная задача в списке без дополнительных параметров.
final class RegularTask: Task {}

extension RegularTask: CustomStringConvertible {
    var description: String {
        "- [\(completed ? "x" : " ")] \(title)"
    }
}

// MARK: - ImportantTask

/// Важная задача в списке.
/// Содержит приоритет и срок выполнения.
final class ImportantTask: Task {
	
	// MARK: - Types
	
    enum TaskPriority {
        case low, medium, high
    }
	
	// MARK: - Public Properties
	
	/// Приоритет задачи.
    var taskPriority: TaskPriority
	
	/// Срок выполнения задачи.
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
	
	// MARK: - Private Properties
	
	private var oneDayTime: TimeInterval = 60*60*24
	
	// MARK: - Initializers
    
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
