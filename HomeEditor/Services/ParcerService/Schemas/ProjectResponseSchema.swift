//
//  ProjectResponseSchema.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit
struct Project: Decodable {
    let name: String
    let identifier: UUID
    let house: House
}

struct House: Decodable {
    let rooms: [Room]
}

struct Wall: Decodable {
    let start: CGPoint
    let end: CGPoint
}

struct Room: Decodable {
    let position: CGPoint
    let walls: [Wall]
    
//    func makePath() -> UIBezierPath {
//        let path = UIBezierPath()
//        path.lineWidth = 5
//        guard let startPoint = walls.first?.start else {
//            return UIBezierPath()
//        }
//        path.move(to: startPoint)
//        walls.forEach {
//            path.move(to: $0.end)
//        }
//        path.fill()
//        return path
//    }
}
