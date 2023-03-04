//
//  SectionForTaskManagerAdapter.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 01.03.2023.
//

import Foundation

/// Протокол адаптера менеджера задач, разбивающий задачи на секции
protocol ISectionForTaskManagerAdapter {
	/// Возвращает массив названий секций.
	/// - Returns: массив названий секций
	func getSectionTitles() -> [String]
	/// Возвращает задачи для секции.
	/// - Parameter sectionIndex: номер секции.
	/// - Returns: массив задач для указанной секции.
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionTitles() -> [String] {
		return ["In progress", "Completed"]
	}
	
	func getTasksForSection(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 1:
			return taskManager.completedTasks()
		default:
			return taskManager.uncompletedTasks()
		}
	}
}
