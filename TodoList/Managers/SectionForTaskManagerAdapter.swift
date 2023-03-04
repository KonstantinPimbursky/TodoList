//
//  SectionForTaskManagerAdapter.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 01.03.2023.
//

import Foundation

/// Протокол адаптера менеджера задач, разбивающий задачи на секции
protocol ISectionForTaskManagerAdapter {
	/// Возвращает массив секций.
	/// - Returns: массив секций
	func getSections() -> [Section]
	/// Возвращает задачи для секции.
	/// - Parameter sectionIndex: номер секции.
	/// - Returns: массив задач для указанной секции.
	func getTasksForSection(section: Section) -> [Task]
	func getTask(forIndexPath indexPath: IndexPath) -> Task
}

enum Section: CaseIterable {
	case uncompleted
	case completed
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSections() -> [Section] {
		return Section.allCases
	}
	
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}
	
	func getTask(forIndexPath indexPath: IndexPath) -> Task {
		let sections = getSections()
		let sectionTasks = getTasksForSection(section: sections[indexPath.section])
		return sectionTasks[indexPath.row]
	}
}
