//
//  TaskManager.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTask(task: Task)
	func removeTask(task: Task)
}

final class TaskManager: ITaskManager {
	private var taskList = [Task]()
	
	init() {
		addTask(task: ImportantTask(title: "go to shop", taskPriority: .high, completed: false))
		addTask(task: RegularTask(title: "do homework", completed: true))
		addTask(task: ImportantTask(title: "watch Avatar 2", taskPriority: .low, completed: false))
		addTask(task: ImportantTask(title: "watch TV", taskPriority: .medium, completed: false))
	}
	
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
