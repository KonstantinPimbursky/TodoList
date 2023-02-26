//
//  UIView+Extensions.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

extension UIView {
	/// Возвращает название класса, чтобы его использовать для регистрации ячеек
	static var identifier: String {
		return String(describing: self)
	}
	
	/// Добавляет в subviews массив `UIView`
	/// - Parameter views: массив `UIView`, которые необходимо добавить как subview
	func addSubviews(_ views: [UIView]) {
		views.forEach { addSubview($0) }
	}
}
