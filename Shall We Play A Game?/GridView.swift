//
//  GridView.swift
//  Shall We Play A Game?
//
//  Created by Jaswitha Reddy G on 1/28/23.
//

import Foundation
import UIKit

class GridView: UIView {
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        
        // Two vertical lines
        path.move(to: CGPoint(x: 100, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.move(to: CGPoint(x: 200, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 300))
        
        // Two horizontal lines
        path.move(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 300, y: 100))
        path.move(to: CGPoint(x: 0, y: 200))
        path.addLine(to: CGPoint(x: 300, y: 200))
        
        // Set color of the lines
        UIColor.purple.setStroke()
        path.lineWidth = 5
        path.stroke()
    }
}
