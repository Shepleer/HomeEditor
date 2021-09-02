//
//  ProjectParcer.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

protocol IProjectParcer {
    func fetchProjects(projectsNames: [String], _ onComplete: @escaping (Result<[Project], Error>) -> Void)
}

class ProjectParcer: IProjectParcer {
    enum ParcerError: Error {
        case badLocalPath
        case dataBuildError
        case parcingError
    }
    
    private let proccessQueue = DispatchQueue(label: "parcer_queue", qos: .userInitiated)
    
    func fetchProjects(projectsNames: [String], _ onComplete: @escaping (Result<[Project], Error>) -> Void) {
        do {
            let data = try buildURLs(by: projectsNames)
            print(DispatchPredicate.onQueue(DispatchQueue.main))
            proccessQueue.async { [weak self] in
                guard let self = self else { return }
                guard let projects: [Project] = try? self.parce(data) else {
                    onComplete(.failure(ParcerError.parcingError))
                    return
                }
                DispatchQueue.main.async {
                    onComplete(.success(projects))
                }
            }
        } catch let error {
            onComplete(.failure(error))
            return
        }
    }
    
    private func buildURLs(by projectNames: [String]) throws -> [Data] {
        let paths = projectNames.map {
            Bundle.main.path(forResource: $0, ofType: "json")
        }
        
        let urls: [URL] = try paths.map {
            if let path = $0 {
                return URL(fileURLWithPath: path)
            } else {
                throw ParcerError.badLocalPath
            }
        }
        
        let rawProjects: [Data] = try urls.map {
            do {
                return try Data(contentsOf: $0)
            } catch {
                throw ParcerError.dataBuildError
            }
        }
        
        return rawProjects
    }
    
    private func parce<T: Decodable>(_ rawData: [Data]) throws -> [T] {
        print(DispatchPredicate.onQueue(proccessQueue))
        let models = try rawData.map {
            try JSONDecoder().decode(T.self, from: $0)
        }
        return models
    }
}
