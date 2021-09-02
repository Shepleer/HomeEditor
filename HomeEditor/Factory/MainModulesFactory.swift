//
//  MainModulesFactory.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

protocol MainModulesFactory {
    func makeProjectsListModule() -> ProjectsListModule
    func makeEditorModule(with payload: Project) -> EditorModule
}

class MainModulesFactoryImpl: MainModulesFactory {
    func makeProjectsListModule() -> ProjectsListModule {
        ProjectsListModuleAssembly.makeModule()
    }
    
    func makeEditorModule(with payload: Project) -> EditorModule {
        EditorModuleAssembly.makeModule(with: payload)
    }
}
