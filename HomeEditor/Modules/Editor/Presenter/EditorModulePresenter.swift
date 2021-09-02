//
//  EditorModulePresenter.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

class EditorPresenter: EditorViewToPresenterProtocol {
    
    weak var view: EditorPresenterToViewProtocol?
    weak var moduleDelegate: EditorModuleDelegate?
    
    private var project: Project
    
    init(with payload: Project) {
        self.project = payload
    }
    
    func viewDidLoad() {
        view?.configure(project: project)
    }
}
