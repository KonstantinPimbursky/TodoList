//
//  TaskManager.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

protocol ITaskManager: AnyObject {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTask(task: Task)
	func removeTask(task: Task)
}

final class TaskManager: ITaskManager {
	
	// MARK: - Private Properties
	
	private var taskList = [Task]()
	
	// MARK: - Public Methods
	
	func allTasks() -> [Task] {
		taskList
	}
	
	func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}
	
	func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}
	
	func addTask(task: Task) {
		taskList.append(task)
	}
	
	func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
