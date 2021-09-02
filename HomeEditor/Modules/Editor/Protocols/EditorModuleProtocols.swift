//
//  EditorModuleProtocols.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

protocol EditorViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol EditorPresenterToViewProtocol: AnyObject {
    func configure(project: Project)
}

protocol EditorModuleDelegate: AnyObject {
    func moveBack()
}

protocol EditorModule: Module {
    func setup(delegate: EditorModuleDelegate)
}
