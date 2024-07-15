//
//  WorryCategoryView .swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then
import CoreMotion
import RxSwift

class WorryCategoryView: UIView {
    
    var worries: [BubbleView] = []
    private var gravity: UIGravityBehavior?
    private var collision: UICollisionBehavior?
    private var animator: UIDynamicAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupView()
        bindActions()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if worries.isEmpty {
            setupBubbles()
        }
    }
    
    private func setupView() {
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
            $0.top.equalTo(worryBox.snp.bottom).offset(20)
            $0.width.height.equalTo(60)
            $0.centerX.equalTo(self)
        }
    }
    
    private func setupBubbles() {
        
        animator = UIDynamicAnimator(referenceView: self.worryBox)
        
       
        gravity = UIGravityBehavior()
        gravity?.gravityDirection = CGVector(dx: 0, dy: 1) // Gravity direction
        animator?.addBehavior(gravity!)
        

        collision = UICollisionBehavior()
        collision?.translatesReferenceBoundsIntoBoundary = true // Set the boundaries of the view
        animator?.addBehavior(collision!)
        
       
        for _ in 0..<15 {
            let randX = Int.random(in: 0..<Int(self.worryBox.frame.size.width - 60))
            let randY = Int.random(in: 0..<Int(self.worryBox.frame.size.height - 60))
            
            let bubble = BubbleView(
                frame: CGRect(x: randX, y: randY, width: 100, height: 100)
            )
            bubble.backgroundColor = .mainPurple
            self.worryBox.addSubview(bubble)
            worries.append(bubble)
            
            
            gravity?.addItem(bubble)
            collision?.addItem(bubble)
        }
    }
    
    // MARK: UI Elements
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
    private func bindActions() {
           addButton.rx.tap
               .subscribe(onNext: { [weak self] in
                   self?.handleAddButtonTap()  // 액션 처리 메소드 호출
               })
               .disposed(by: disposeBag)
       }
       
       private func handleAddButtonTap() {
           print("Add Button Tapped")
           // 버튼 클릭 시의 동작을 구현합니다.
       }
       
       private let disposeBag = DisposeBag()
}
