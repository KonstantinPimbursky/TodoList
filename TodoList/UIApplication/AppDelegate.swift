//
//  AppDelegate.swift
//  TodoList
//
//  Created by Konstantin Pimbursky on 25.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let taskManager = TaskManager()

		let regularTask = RegularTask(title: "normalTask")
		let importantTask = ImportantTask(title: "importantTask", taskPriority: .low)

		taskManager.addTask(task: RegularTask(title: "Task 1"))
		taskManager.addTask(task: RegularTask(title: "Task 2"))
		taskManager.addTask(task: RegularTask(title: "Task 3"))

		let importantTask3 = ImportantTask(title: "ImportantTask 3", taskPriority: .high)
		taskManager.addTask(task: ImportantTask(title: "ImportantTask 1", taskPriority: .low))
		taskManager.addTask(task: ImportantTask(title: "ImportantTask 2", taskPriority: .medium))
		taskManager.addTask(task: importantTask3)

		importantTask3.completed = true
		
		let viewController = TodoListController(taskManager: taskManager)
		
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
		
		return true
	}


}

