//
//  Repository.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 01.03.2023.
//

import Foundation

protocol ITaskRepository {
	func getTasks() -> [Task]
}

final class TaskRepository: ITaskRepository {
	func getTasks() -> [Task] {
		[
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Dow workout"),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)
		]
	}
}
