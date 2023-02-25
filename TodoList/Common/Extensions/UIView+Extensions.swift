//
//  UIView+Extensions.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

extension UIView {
	// Return class name for use it in Register cells
	static var identifier: String {
		return String(describing: self)
	}
}
