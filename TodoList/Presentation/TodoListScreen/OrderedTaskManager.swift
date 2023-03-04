//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 01.03.2023.
//

import Foundation

final class OrderedTaskManager: ITaskManager {
	
	// MARK: - Private Properties
	
	private let taskManager: ITaskManager
	
	// MARK: - Initializers
	
	init(taskManage: ITaskManager) {
		self.taskManager = taskManage
	}
	
	// MARK: - Public Methods
	
	func allTasks() -> [Task] {
		sort(tasks: taskManager.allTasks())
	}
	
	func completedTasks() -> [Task] {
		sort(tasks: taskManager.completedTasks())
	}
	
	func uncompletedTasks() -> [Task] {
		sort(tasks: taskManager.uncompletedTasks())
	}
	
	func addTask(task: Task) {
		taskManager.addTask(task: task)
	}
	
	func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}
	
	// MARK: - Private Methods
	
	private func sort(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask,
			   let task1 = $1 as? ImportantTask {
				return task0.taskPriority > task1.taskPriority
			}
			
			if $0 is ImportantTask, $0 is RegularTask {
				return true
			}
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			
			return true
		}
	}
}

extension ImportantTask.TaskPriority: Comparable {
	static func < (lhs: ImportantTask.TaskPriority, rhs: ImportantTask.TaskPriority) -> Bool {
		lhs.mesure < rhs.mesure
	}
}

extension ImportantTask.TaskPriority {
	var mesure: Int {
		switch self {
		case .low:
			return 0
		case .medium:
			return 1
		case .high:
			return 2
		}
	}
}
