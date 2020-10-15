//
//  CustomTabBar.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit
class CustomTabBar: UITabBar {
    private let waveSubLayer: CAShapeLayer = {
        let subLayer = CAShapeLayer()
        subLayer.strokeColor = #colorLiteral(red: 0.833518401, green: 0.833518401, blue: 0.833518401, alpha: 0.2536922089)
        subLayer.lineWidth = 2
        subLayer.fillColor = UIColor.white.cgColor
        return subLayer
    }()
    
    private func addShape() {
        let path = UIBezierPath.createCurve(at: self.frame.width / 2, radius: 36, on: self)
        waveSubLayer.path = path.cgPath
        self.layer.insertSublayer(waveSubLayer, at: 0)
    }
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
}

extension UIBezierPath {
    
    class func createCurve(at center: CGFloat, radius curve: CGFloat, on tabBar: UITabBar) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: center - (curve * 1.4), y: 0))
        path.addQuadCurve(to: CGPoint(x: center - curve, y: curve / 1.4), controlPoint: CGPoint(x: center - curve - curve / 7.5, y: 0))
        path.addCurve(to: CGPoint(x: center + curve, y: curve / 1.4),
                      controlPoint1: CGPoint(x: center - curve + curve / 4, y: curve + curve / 1.4),
                      controlPoint2: CGPoint(x: center + curve - curve / 4, y: curve + curve / 1.4))
        path.addQuadCurve(to: CGPoint(x: center + (curve * 1.4), y: 0), controlPoint: CGPoint(x: center + curve + curve / 7.5, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBar.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        path.close()
        return path
    }
    
}

