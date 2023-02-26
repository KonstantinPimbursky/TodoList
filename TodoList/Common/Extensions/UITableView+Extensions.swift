//
//  UITableView+Extensions.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

extension UITableView {
	/// Хелпер для регистрации ячеек в таблице
	/// - Parameter cell: тип ячейки, которую необходимо зарегистрировать
	func register<T: UITableViewCell>(cell: T.Type) {
		register(T.self, forCellReuseIdentifier: T.identifier)
	}
	
	/// Создает ячейку из таблицы по указанному indexPath
	/// - Parameter indexPath: indexPath по которому необходимо создать ячейку
	/// - Returns: ячейка для указанного indexPath
	func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
	}
}
