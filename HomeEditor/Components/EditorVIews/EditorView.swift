//
//  EditorView.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit


class EditorView: UIView {
    private struct Appearance {
        static let editorSize = CGSize(width: 1000, height: 1000)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupGrid()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // So I decided that editor should have a stable size
    override var intrinsicContentSize: CGSize {
        Appearance.editorSize
    }
    
    override func layoutSublayers(of layer: CALayer) {
        layer.sublayers?.forEach {
            if let grid = $0 as? GridLayer {
                grid.frame = layer.bounds
                grid.setNeedsDisplay()
            }
        }
    }
    
    func configure(project: Project) {
        makeHouse(from: project.house)
    }
    
    private func makeHouse(from house: House) {
        house.rooms.forEach { room in
            let view = RoomView(room: room)
            addSubview(view)
        }
    }
    
    private func setupGrid() {
        let bigGrid = GridLayer()
        bigGrid.squareSize = CGSize(width: 100, height: 100)
        bigGrid.strokeColor = UIColor.white.cgColor
        bigGrid.lineWidth = 1
        bigGrid.bounds = bounds
        
        let smallGrid = GridLayer()
        smallGrid.squareSize = CGSize(width: 25, height: 25)
        smallGrid.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor
        smallGrid.lineWidth = 0.5
        smallGrid.bounds = bounds
        
        layer.insertSublayer(bigGrid, at: 0)
        layer.insertSublayer(smallGrid, at: 0)
    }
}
