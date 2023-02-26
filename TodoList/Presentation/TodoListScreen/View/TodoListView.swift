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
		tableView.allowsSelection = false
		return tableView
	}()
	
	// MARK: - Initializers
	
	init() {
		super.init(frame: .zero)
		backgroundColor = .white
		addSubviews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private Methods
	
	private func addSubviews() {
		addSubview(tableView)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
