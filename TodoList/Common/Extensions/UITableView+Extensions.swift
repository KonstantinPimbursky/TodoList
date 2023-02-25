//
//  UITableView+Extensions.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

extension UITableView {
	func register<T: UITableViewCell>(cell: T.Type) {
		register(T.self, forCellReuseIdentifier: T.identifier)
	}
	
	func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
	}
}
