//
//  EditorModuleAssembly.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class EditorModuleAssembly {
    static func makeModule(with payload: Project) -> EditorModule {
        let view = EditorViewController()
        let presenter = EditorPresenter(with: payload)
        
        view.presenter = presenter
        presenter.view = view
        
        return EditorModuleImpl(view: view, presenter: presenter)
    }
}

private class EditorModuleImpl: EditorModule {
    
    private var viewController: UIViewController
    private var presenter: EditorPresenter
    
    init(view: UIViewController, presenter: EditorPresenter) {
        self.viewController = view
        self.presenter = presenter
    }
    
    func toPresent() -> UIViewController {
        viewController
    }
    
    func setup(delegate: EditorModuleDelegate) {
        self.presenter.moduleDelegate = delegate
    }
}
