//
//  TodoListController.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

class TodoListController: UIViewController {
	
	// MARK: - Private Properties
	
	private let mainView = TodoListView()
	
	private let taskManager: ITaskManager
	
	private let model: TodoListModel
	
	// MARK: - Initializers
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
		self.model = TodoListModel(tasks: taskManager.allTasks())
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life Cycle
	
	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTable()
	}
	
	// MARK: - Private Methods
	
	private func setupTable() {
		mainView.tableView.dataSource = self
		mainView.tableView.delegate = self
	}
}

// MARK: - UITableViewDataSource

extension TodoListController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		model.numberOfSections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		model.numberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TodoListCell = tableView.dequeueCell(for: indexPath)
		let task = model.getTask(atIndexPath: indexPath)
		cell.configure(byTask: task)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension TodoListController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		64
	}
}
