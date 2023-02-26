//
//  TodoListController.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 26.02.2023.
//

import UIKit

final class TodoListController: UITableViewController {
	
	// MARK: - Private Properties
	
	private let taskManager: ITaskManager = TaskManager()
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "TodoList"
	}
	
	// MARK: - Public Methods
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section == 0 ? taskManager.completedTasks().count : taskManager.uncompletedTasks().count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellData = getCellData(indexPath)
		let cell = UITableViewCell()
		
		var content = cell.defaultContentConfiguration()
		
		if let cellData = cellData as? RegularTask {
			content.text = cellData.title
		} else if let cellData = cellData as? ImportantTask {
			let priorityTitle = getPriorityTitle(cellData.taskPriority)
			let text = priorityTitle + " " + cellData.title
			
			let range = (text as NSString).range(of: priorityTitle)
			let mutableAttributedString = NSMutableAttributedString(
				string: text,
				attributes: [.foregroundColor: UIColor.black]
			)
			
			content.attributedText = mutableAttributedString
			content.secondaryText = "Deadline: " + cellData.deadline.formatted(.dateTime)
			content.textProperties.color = cellData.deadline < Date() ? .systemGray : .systemPink
		}
		
		cell.tintColor = indexPath.section == 0 ? .red : .systemGray
		
		content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.accessoryType = .checkmark
		cell.contentConfiguration = content
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		section == 0 ? "Completes tasks" : "Uncompleted tasks"
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cellData = getCellData(indexPath)
		cellData.completed.toggle()
		var row = 0
		if indexPath.section == 0 {
			taskManager.uncompletedTasks().enumerated().forEach {
				if $0.element === cellData {
					row = $0.offset
				}
			}
			let newIndexPath = IndexPath(row: row, section: 1)
			tableView.moveRow(at: indexPath, to: newIndexPath)
			tableView.cellForRow(at: newIndexPath)?.tintColor = .systemGray
			tableView.deselectRow(at: newIndexPath, animated: true)
		} else {
			taskManager.completedTasks().enumerated().forEach {
				if $0.element === cellData {
					row = $0.offset
				}
			}
			let newIndexPath = IndexPath(row: row, section: 0)
			tableView.moveRow(at: indexPath, to: newIndexPath)
			tableView.cellForRow(at: newIndexPath)?.tintColor = .red
			tableView.deselectRow(at: newIndexPath, animated: true)
		}
	}
	
	// MARK: - Private Methods
	
	private func getCellData(_ indexPath: IndexPath) -> Task {
		indexPath.section == 0 ? taskManager.completedTasks()[indexPath.row] : taskManager.uncompletedTasks()[indexPath.row]
	}
	
	private func getPriorityTitle(_ priority: ImportantTask.TaskPriority) -> String {
		switch priority {
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
	
}
