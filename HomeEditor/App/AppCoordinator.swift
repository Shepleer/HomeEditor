//
//  AppCoordinator.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class AppCoordinator: Coordinator, UISplitViewControllerDelegate {
    
    var window: UIWindow
    static let shared = AppCoordinator()
    
    private var factory: MainModulesFactory = MainModulesFactoryImpl()
    private var router = UINavigationController()
    
    private init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        moveToProjectsListModule()
    }
}

extension AppCoordinator: ProjectsListModuleDelegate {
    func moveToEditorScreen(with payload: Project) {
        let module = factory.makeEditorModule(with: payload)
        router.pushViewController(module.toPresent(), animated: true)
    }
}

private extension AppCoordinator {
    func moveToProjectsListModule() {
        let module = factory.makeProjectsListModule()
        module.setup(delegate: self)
        router.pushViewController(module.toPresent(), animated: false)
        window.rootViewController = router
        window.makeKeyAndVisible()
    }
}
