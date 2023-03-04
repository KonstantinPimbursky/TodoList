//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 04.03.2023.
//

import Foundation

protocol ITodoListPresenter {
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
}

final class TodoListPresenter: ITodoListPresenter {
	
	// MARK: - Private Properties
	
	private var sectionManager: ISectionForTaskManagerAdapter
	private weak var view: ITodoListController?
	
	// MARK: - Initializers
	
	init(view: ITodoListController, sectionManager: ISectionForTaskManagerAdapter) {
		self.sectionManager = sectionManager
		self.view = view
	}
	
	// MARK: - Public Methods
	
	func viewIsReady() {
		view?.render(viewData: mapViewData())
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		let task = sectionManager.getTask(forIndexPath: indexPath)
		task.completed.toggle()
		view?.render(viewData: mapViewData())
	}
	
	// MARK: - Private Methods
	
	private func mapViewData() -> TodoListModel.ViewData {
		var sections = [TodoListModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = TodoListModel.ViewData.Section(
				title: section.title,
				tasks: mapTaskData(tasks: sectionManager.getTasksForSection(section: section))
			)
			
			sections.append(sectionData)
		}
		
		return TodoListModel.ViewData(tasksBySections: sections)
	}
	
	private func mapTaskData(tasks: [Task]) -> [TodoListModel.ViewData.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TodoListModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = TodoListModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.deadline < Date(),
				deadLine: "Deadline: \(task.deadline)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(TodoListModel.ViewData.RegularTask(name: task.title, isDone: task.completed))
		}
	}
}
