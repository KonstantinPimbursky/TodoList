//
//  TodoListView.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

final class TodoListView: UIView {
	
	// MARK: - Public Properties
	
	public let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(cell: TodoListCell.self)
		return tableView
	}()
	
	// MARK: - Initializers
	
	init() {
		super.init(frame: .zero)
		backgroundColor = .white
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
