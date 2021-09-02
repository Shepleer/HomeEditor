//
//  ProjectsListPresenter.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

class ProjectsListPresenter {
    private struct Constants {
        static let projectsNames = ["Project 1", "Project 2", "Project 3"]
    }
    
    
    private var projectParcer: IProjectParcer = ProjectParcer()
    weak var view: ProjectsListPresenterToViewProtocol?
    weak var moduleDelegate: ProjectsListModuleDelegate?
    
    private var projects: [Project] = []
}

extension ProjectsListPresenter: ProjectsListViewToPresenterProtocol {
    func viewDidLoad() {
        projectParcer.fetchProjects(
            projectsNames: Constants.projectsNames
        ) { [weak self] result in
            guard let self = self else { return }
            self.view?.update(.loading)
            switch result {
            case .success(let projects):
                self.projects = projects
                self.view?.update(projects)
                self.view?.update(.done)
            case .failure:
                self.view?.update(.error("Parsing error"))
            }
        }
    }
    
    func cell(didTappedAt indexPath: IndexPath) {
        let model = projects[indexPath.row]
        moduleDelegate?.moveToEditorScreen(with: model)
    }
}
