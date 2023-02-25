//
//  Task.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

class Task {
	
	// MARK: - Public Properties
	
	var title: String
	var completed = false
	
	// MARK: - Initializers
	
	init(title: String) {
		self.title = title
	}
}

final class RegularTask: Task {}

final class ImportantTask: Task {
	
	// MARK: - Types
	
	enum TaskPriority {
		case low, medium, high
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
