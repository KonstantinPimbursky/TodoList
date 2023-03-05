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
		
		let todoListController = createTodoListController()
		
		window?.rootViewController = todoListController
		window?.makeKeyAndVisible()
		
		let loginController = createLoginViewController()
		todoListController.present(loginController, animated: false)
		
		return true
	}
	
	private func createTodoListController() -> UIViewController {
		let defaultTaskManager = TaskManager()
		let repository = TaskRepository()
		repository.getTasks().forEach {
			defaultTaskManager.addTask(task: $0)
		}
		let orderedTaskManager = OrderedTaskManager(taskManage: defaultTaskManager)
		let sectionManager = SectionForTaskManagerAdapter(taskManager: orderedTaskManager)
		
		let todoListController = TodoListController()
		todoListController.presenter = TodoListPresenter(view: todoListController, sectionManager: sectionManager)
		return todoListController
	}
	
	private func createLoginViewController() -> UIViewController {
		let presenter = LoginPresenter()
		let worker = LoginWorker()
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		let loginController = LoginViewController(interactor: interactor)
		presenter.viewController = loginController
		loginController.modalPresentationStyle = .fullScreen
		return loginController
	}
}
