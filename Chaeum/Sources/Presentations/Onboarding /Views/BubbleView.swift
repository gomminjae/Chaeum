//
//  BubbleView.swift
//  Chaeum
//
//  Created by 권민재 on 7/1/24.
//

import UIKit
import SnapKit
import Then

class BubbleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.addSublayer(shapeLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }

    override var collisionBoundingPath: UIBezierPath {
        return circularPath()
    }

    private func circularPath(lineWidth: CGFloat = 0, center: CGPoint = .zero) -> UIBezierPath {
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    }

    lazy var shapeLayer = CAShapeLayer().then {
        $0.fillColor = UIColor.clear.cgColor
        $0.allowsEdgeAntialiasing = true
        $0.backgroundColor = UIColor.clear.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.width / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.path = circularPath(lineWidth: 0, center: center).cgPath
    }
}
