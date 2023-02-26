//
//  ImportantTask.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

final class ImportantTask: Task {
	
	// MARK: - Types
	
	enum TaskPriority {
		case low, medium, high
		
		var title: String {
			switch self {
			case .high:
				return "High"
			case .medium:
				return "Medium"
			case .low:
				return "Low"
			}
		}
	}
	
	// MARK: - Public Properties
	
	var taskPriority: TaskPriority
	
	var deadline: Date? {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())
		}
	}
	
	// MARK: - Initializers
	
	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}

// MARK: - CustomStringConvertible

extension ImportantTask: CustomStringConvertible {
	var description: String {
		"- [\(completed ? "x" : " ")] Important, priority \(taskPriority): \(title)."
	}
}
