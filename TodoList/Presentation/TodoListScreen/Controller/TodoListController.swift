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
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TodoListCell = tableView.dequeueCell(for: indexPath)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension TodoListController: UITableViewDelegate {
	
}
