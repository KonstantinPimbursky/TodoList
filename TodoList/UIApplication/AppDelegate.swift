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
		
		let defaultTaskManager = TaskManager()
		let repository = TaskRepository()
		repository.getTasks().forEach {
			defaultTaskManager.addTask(task: $0)
		}
		let orderedTaskManager = OrderedTaskManager(taskManage: defaultTaskManager)
		let sectionManager = SectionForTaskManagerAdapter(taskManager: orderedTaskManager)
		
		let todoListController = TodoListController()
		todoListController.presenter = TodoListPresenter(view: todoListController, sectionManager: sectionManager)
		
		window?.rootViewController = todoListController
		window?.makeKeyAndVisible()
		
		return true
	}


}

