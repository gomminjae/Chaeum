//
//  WorryCategoryView .swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then


class WorryCategoryView: UIView {
    
    var worries: [BubbleView] = []
    var gravity: Gravity?
    var gravityItems: [UIDynamicItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupView()
        setupBubbles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBubbles() {
        // Add this guard statement to avoid issues if the frame size is too small
        guard self.worryBox.frame.size.width > 100 && self.worryBox.frame.size.height > 100 else {
            print("Error: worryBox frame size is too small to fit bubbles.")
            return
        }
        
        for _ in 0..<6 {
            let randX = Int.random(in: 0..<Int(self.worryBox.frame.size.width - 100))
            let randY = Int.random(in: 0..<Int(self.worryBox.frame.size.height - 100))
            
            let bubble = BubbleView(
                frame: CGRect(x: randX, y: randY, width: 60, height: 60)
            )
            self.worryBox.addSubview(bubble)
        }
        
        // prepare the bubbles to pass to SDK
        gravityItems = self.worryBox.subviews.filter{ $0 is BubbleView }
        
        gravity = Gravity(
            gravityItems: gravityItems, // <<-- your bubbles
            collisionItems: nil,
            referenceView: self.worryBox,
            boundary: UIBezierPath(rect: self.worryBox.bounds), // Use bounds instead of frame for accurate collision boundary
            queue: nil
        )
        
        // start gravity
        gravity?.enable()
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(addButton)
        addSubview(worryBox)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self).inset(20)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(40)
        }
        
        worryBox.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(self).inset(20)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(worryBox.snp.bottom).offset(20) // Adjusted to avoid overlap
            $0.width.height.equalTo(60)
            $0.centerX.equalTo(self)
        }
        
        // Ensure that layout constraints are applied
     
    }
    


    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "당신은 어떤 걱정을 하고 있나요?"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
    }
    
    lazy var addButton = UIButton().then {
        $0.backgroundColor = .subPurple
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    
    lazy var worryBox = UIView().then {
        $0.backgroundColor = .contentColor
        $0.layer.cornerRadius = 15
    }
}
