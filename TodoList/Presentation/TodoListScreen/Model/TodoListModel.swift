//
//  TodoListModel.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

struct TodoListModel {
	
	// MARK: - Public Properties
	
	var numberOfSections: Int = 1
	var numberOfRowsInSection: Int {
		allTasks.count
	}
	
	// MARK: - Private Properties
	
	private var allTasks = [Task]()
	
	// MARK: - Initializers
	
	init(tasks: [Task]) {
		self.allTasks = tasks
	}
	
	// MARK: - Public Methods
	
	func getTask(atIndexPath indexPath: IndexPath) -> Task {
		allTasks[indexPath.row]
	}
}
