//
//  RoomVIew.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class RoomView: UIView {
    
    var room: Room
    
    var pathSize: CGSize = .zero
    
    init(room: Room) {
        self.room = room
        super.init(frame: .zero)
        setupRoom(with: room.walls)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRoom(with walls: [Wall]) {
        let path = UIBezierPath()
        path.lineWidth = 5
        guard let startPoint = walls.first?.start else {
            return
        }
        path.move(to: startPoint)
        walls.forEach {
            path.addLine(to: $0.end)
        }
        path.fill()
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.darkGray.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.path = path.cgPath
        layer.frame = path.bounds
        pathSize = path.bounds.size
        frame.size = path.bounds.size
        center = room.position
        self.layer.insertSublayer(layer, at: 0)
    }
}
