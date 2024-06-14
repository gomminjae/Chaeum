//
//  SegmentedProgressBar.swift
//  Chaeum
//
//  Created by 권민재 on 6/14/24.
//
import UIKit

class SegmentedProgressBar: UIView {
    
    var segmentCount: Int = 4
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var segmentLayers: [CALayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegments()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSegments()
    }
    
    private func setupSegments() {
        for _ in 0..<segmentCount {
            let segmentLayer = CALayer()
            segmentLayer.backgroundColor = UIColor.lightGray.cgColor
            segmentLayer.cornerRadius = 6
            layer.addSublayer(segmentLayer)
            segmentLayers.append(segmentLayer)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let segmentWidth = bounds.width / CGFloat(segmentCount)
        let segmentHeight = 10.0
        let completedSegments = Int(progress * CGFloat(segmentCount))
        
        for (index, segmentLayer) in segmentLayers.enumerated() {
            let segmentFrame = CGRect(x: CGFloat(index) * segmentWidth, y: 0, width: segmentWidth - 1, height: segmentHeight)
            segmentLayer.frame = segmentFrame
            
            if index < completedSegments {
                segmentLayer.backgroundColor = UIColor.blue.cgColor
            } else {
                segmentLayer.backgroundColor = UIColor.lightGray.cgColor
            }
        }
    }
}
