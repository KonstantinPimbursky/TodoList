//
//  Task.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import Foundation

class Task {
	
	// MARK: - Public Properties
	
	var title: String
	var completed = false
	
	// MARK: - Initializers
	
	init(title: String) {
		self.title = title
	}
}
