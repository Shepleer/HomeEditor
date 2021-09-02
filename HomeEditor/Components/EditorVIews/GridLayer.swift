//
//  GridLayer.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

// Simple layer to add a grid to a view
class GridLayer: CALayer {
    var squareSize: CGSize = .init(width: 40, height: 40)
    var lineWidth: CGFloat = 4
    var strokeColor: CGColor = UIColor.black.cgColor
    
    override func draw(in ctx: CGContext) {
        let width = bounds.width
        let height = bounds.height
        ctx.beginPath()
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(strokeColor)
        ctx.move(to: .zero)
        
        // Draw horizontal lines
        stride(from: .zero, through: height, by: squareSize.width).forEach {
            ctx.move(to: CGPoint(x: .zero, y: $0))
            ctx.addLine(to: CGPoint(x: width, y: $0))
        }

        // Draw vertical lines
        stride(from: .zero, through: width, by: squareSize.height).forEach {
            ctx.move(to: CGPoint(x: $0, y: .zero))
            ctx.addLine(to: CGPoint(x: $0, y: height))
        }
        
        ctx.drawPath(using: .stroke)
    }
}
