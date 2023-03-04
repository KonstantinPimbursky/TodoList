//
//  TodoListModel.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 04.03.2023.
//

import Foundation

enum TodoListModel {
	struct ViewData {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySections: [Section]
	}
}
