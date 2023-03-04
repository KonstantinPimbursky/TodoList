//
//  TodoListController.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

protocol ITodoListController: AnyObject {
	func render(viewData: TodoListModel.ViewData)
}

/// Контроллер отображения списка задач.
final class TodoListController: UITableViewController {
    
    // MARK: - Private Properties
    
	var viewData: TodoListModel.ViewData = TodoListModel.ViewData(tasksBySections: [])
	var presenter: ITodoListPresenter?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TodoList"
		presenter?.viewIsReady()
    }
    
    // MARK: - Public Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.tasksBySections[section].tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let cellData = tasks[indexPath.row]
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        
		switch cellData {
		case .regularTask(let regularTask):
			content.text = regularTask.name
			cell.accessoryType = regularTask.isDone ? .checkmark : .none
		case .importantTask(let importantTask):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(importantTask.priority) ", attributes: redText)
			taskText.append(NSAttributedString(string: importantTask.name))
			
			content.attributedText = taskText
			content.secondaryText = importantTask.deadLine
			content.textProperties.color = importantTask.isOverdue ? .systemPink : .black
			cell.accessoryType = importantTask.isDone ? .checkmark : .none
		}
        
        cell.tintColor = .red
        
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didTaskSelected(at: indexPath)
    }    
}

// MARK: - ITodoListController

extension TodoListController: ITodoListController {
	func render(viewData: TodoListModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
