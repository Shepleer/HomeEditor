//
//  ProjectsListModuleProtocols.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

protocol ProjectsListViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func cell(didTappedAt indexPath: IndexPath)
}

protocol ProjectsListPresenterToViewProtocol: AnyObject {
    func update(_ dataSource: [Project])
    func update(_ state: LoadingState)
}

protocol ProjectsListModuleDelegate: AnyObject {
    func moveToEditorScreen(with payload: Project)
}

protocol ProjectsListModule: Module {
    func setup(delegate: ProjectsListModuleDelegate)
}
