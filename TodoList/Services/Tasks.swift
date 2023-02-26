//
//  Tasks.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

class Task {
	var title: String
	var completed: Bool
	
	init(title: String, completed: Bool) {
		self.title = title
		self.completed = completed
	}
}

final class RegularTask: Task {}

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
	
	init(title: String, taskPriority: TaskPriority, completed: Bool) {
		self.taskPriority = taskPriority
		super.init(title: title, completed: completed)
	}
}

extension RegularTask: CustomStringConvertible {
	var description: String {
		"- [\(completed ? "x" : " ")] \(title)"
	}
}

extension ImportantTask: CustomStringConvertible {
	var description: String {
		"- [\(completed ? "x" : " ")] Important, priority \(taskPriority): \(title)."
	}
}
