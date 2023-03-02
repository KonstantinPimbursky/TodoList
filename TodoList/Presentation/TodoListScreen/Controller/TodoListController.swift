//
//  TodoListController.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

final class TodoListController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let sectionForTaskManager: ISectionForTaskManagerAdapter
    
    // MARK: - Initializers
    
    init(sectionForTaskManager: ISectionForTaskManagerAdapter) {
        self.sectionForTaskManager = sectionForTaskManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TodoList"
    }
    
    // MARK: - Public Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
		sectionForTaskManager.getSectionTitles().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		sectionForTaskManager.getTasksForSection(section: section).count
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
            let mutableAttributedString = NSMutableAttributedString(string: text)
			mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
            
            content.attributedText = mutableAttributedString
            content.secondaryText = "Deadline: " + cellData.deadline.formatted(.dateTime)
            content.textProperties.color = cellData.deadline < Date() ? .systemPink : .black
        }
        
        cell.tintColor = indexPath.section == 0 ? .red : .systemGray
        
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.accessoryType = cellData.completed ? .checkmark : .none
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		sectionForTaskManager.getSectionTitles()[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = getCellData(indexPath)
        cellData.completed.toggle()
		tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func getCellData(_ indexPath: IndexPath) -> Task {
		sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
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
