//
//  SectionForTaskManagerAdapter.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 01.03.2023.
//

import Foundation

protocol ISectionForTaskManagerAdapter {
	func getSectionTitles() -> [String]
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
