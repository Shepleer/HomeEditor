//
//  ProjectsListModuleAssembly.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class ProjectsListModuleAssembly {
    static func makeModule() -> ProjectsListModule {
        let view = ProjectsListViewController()
        let presenter = ProjectsListPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return NumbersDetailModuleImpl(view: view, presenter: presenter)
    }
}

private class NumbersDetailModuleImpl: ProjectsListModule {
    private var view: UIViewController
    private var presenter: ProjectsListPresenter
    
    init(view: UIViewController, presenter: ProjectsListPresenter) {
        self.view = view
        self.presenter = presenter
    }
    
    func toPresent() -> UIViewController {
        view
    }
    
    func setup(delegate: ProjectsListModuleDelegate) {
        presenter.moduleDelegate = delegate
    }
}
