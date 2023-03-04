//
//  TaskManager.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

/// Протокол менеджера задач.
/// Формирует список задач.
protocol ITaskManager: AnyObject {
	/// Возвращает массив всех задач в списке.
	/// - Returns: массив всех задач в списке.
	func allTasks() -> [Task]
	
	/// Возвращает массив завершенных задач.
	/// - Returns: массив завершенных задач.
	func completedTasks() -> [Task]
	
	/// Возвращает массив незавершенных задач.
	/// - Returns: массив незавершенных задач.
	func uncompletedTasks() -> [Task]
	
	/// Добавляет задачу в список.
	/// - Parameter task: задача, которую необходимо добавить в список.
	func addTask(task: Task)
	
	/// Удаляет задачу из списка.
	/// - Parameter task: задача, которую необходимо удалить из списка.
	func removeTask(task: Task)
}

/// Класс стандартного менеджера задач.
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
