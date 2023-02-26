//
//  TodoListCell.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

final class TodoListCell: UITableViewCell {
	
	// MARK: - Private Properties
	
	private weak var task: Task?
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = Colors.blueGrey800
		return label
	}()
	
	private let deadlineLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 10)
		label.textColor = Colors.blueGrey300
		label.isHidden = true
		return label
	}()
	
	private let priorityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 10)
		label.textColor = Colors.blueGrey300
		label.isHidden = true
		return label
	}()
	
	private lazy var labelsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [titleLabel, deadlineLabel, priorityLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 0
		stack.distribution = .fillProportionally
		return stack
	}()
	
	private lazy var checkboxButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = Colors.blue200
		button.layer.cornerCurve = .continuous
		button.layer.cornerRadius = 4
		button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
		button.tintColor = .white
		return button
	}()
	
	// MARK: - Initializers
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life Cycle
	
	override func prepareForReuse() {
		deadlineLabel.isHidden = true
		priorityLabel.isHidden = true
		contentView.backgroundColor = .clear
	}
	
	// MARK: - Public Methods
	
	public func configure(byTask task: Task) {
		self.task = task
		titleLabel.text = task.title
		if let importantTask = task as? ImportantTask {
			setupForImportantTask(importantTask)
		}
		configureCheckmarkButton()
	}
	
	// MARK: - Actions
	
	@objc private func buttonAction(_ sender: UIButton) {
		task?.completed.toggle()
		configureCheckmarkButton()
	}
	
	// MARK: - Private Methods
	
	private func addSubviews() {
		contentView.addSubviews([checkboxButton, labelsStack])
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			checkboxButton.widthAnchor.constraint(equalToConstant: 24),
			checkboxButton.heightAnchor.constraint(equalToConstant: 24),
			checkboxButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			checkboxButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			labelsStack.centerYAnchor.constraint(equalTo: centerYAnchor),
			labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			labelsStack.trailingAnchor.constraint(equalTo: checkboxButton.leadingAnchor, constant: -16),
			labelsStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			labelsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}
	
	private func configureCheckmarkButton() {
		guard let task = task else { return }
		if task.completed {
			checkboxButton.setImage(Images.checkmark, for: .normal)
		} else {
			checkboxButton.setImage(nil, for: .normal)
		}
	}
	
	private func setupForImportantTask(_ task: ImportantTask) {
		guard let deadline = task.deadline else { return }
		
		deadlineLabel.isHidden = false
		priorityLabel.isHidden = false
		
		let dateString = getDateString(deadline)
		deadlineLabel.text = "Deadline: " + dateString
		priorityLabel.text = "Priority: \(task.taskPriority.title)"
		
		let deadlineExpired = deadline.timeIntervalSince1970 < Date().timeIntervalSince1970
		if !task.completed && deadlineExpired {
			contentView.backgroundColor = Colors.pink200
		}
	}
	
	private func getDateString(_ date: Date?) -> String {
		guard let date = date else { return ""}
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter.string(from: date)
	}
}
