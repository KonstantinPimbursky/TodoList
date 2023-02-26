//
//  RegularTask.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import Foundation

final class RegularTask: Task {}

// MARK: - CustomStringConvertible

extension RegularTask: CustomStringConvertible {
	var description: String {
		"- [\(completed ? "x" : " ")] \(title)"
	}
}
