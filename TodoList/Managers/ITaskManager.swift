//
//  ITaskManager.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 04.03.2023.
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

extension ImportantTask.TaskPriority: CustomStringConvertible {
	/// Вес важности приоритета. Используется для сортировки задач по приоритету.
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
	
	var description: String {
		switch self {
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
}
