//
//  OnboardingViewController.swift
//  Chaeum
//
//  Created by 권민재 on 6/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then




class OnboardingViewController: BaseViewController, UITextFieldDelegate {
    
    private var appCoordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    private let currentPage = BehaviorRelay<Int>(value: 0)
    
let segmentedProgressBar = SegmentedProgressBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        view.addSubview(startButton)
        view.addSubview(segmentedProgressBar)

        
        segmentedProgressBar.progress = 0.6
        setupStackView()
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        segmentedProgressBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.width.equalTo(300)
            $0.height.equalTo(20)
            
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(70)
            $0.trailing.equalTo(view.snp.centerX).offset(-10)
        }

        prevButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(70)
            $0.leading.equalTo(view.snp.centerX).offset(10)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }
    }
    
    override func bindRX() {
        currentPage
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] page in
                let lastPage = stackView.arrangedSubviews.count - 1
                UIView.animate(withDuration: 0.3) {
                    self.nextButton.isHidden = page >= lastPage
                    self.prevButton.isHidden = page <= 0 || page >= lastPage
                    self.startButton.isHidden = page != lastPage
                }
            })
            .disposed(by: disposeBag)
//        currentPage
//            .map { CGFloat($0) / CGFloat(self.segmentedProgressBar.segmentCount)}
//            .bind(to: Binder(self) { (vc,progress) in
//                vc.segmentedProgressBar.progress = progress
//            })
//            .disposed(by: disposeBag)
        
        currentPage
            .map { CGFloat($0) / CGFloat(self.segmentedProgressBar.segmentCount)}
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] progress in
                self?.segmentedProgressBar.progress = progress
            })
            .disposed(by: disposeBag)
        
       
        startButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    self.appCoordinator = AppCoordinator(window)
                }
                appCoordinator?.start()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupStackView() {
        
        let headerView = HeaderView()
        let nameView = NameView()
        
        
        [headerView, nameView].forEach { view in
            stackView.addArrangedSubview(view)
            
            view.snp.makeConstraints {
                $0.height.equalTo(300)
            }
        }
    }
    
    // MARK: UI
    lazy var scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.delegate = self
    }
    
    lazy var stackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 0
    }
    
    lazy var nextButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("Next", for: .normal)
        $0.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    lazy var prevButton = UIButton().then {
        $0.backgroundColor = .gray
        $0.setTitle("Prev", for: .normal)
        $0.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
    }
    
    lazy var startButton = UIButton().then {
        $0.backgroundColor = .green
        $0.setTitle("시작하기", for: .normal)
        $0.isHidden = true
    }

    @objc func nextTapped(_ sender: UIButton) {
        let pageHeight = scrollView.frame.size.height
        let maxHeight = pageHeight * CGFloat(stackView.arrangedSubviews.count)
        let currentOffset = scrollView.contentOffset.y
        let newOffset = min(currentOffset + pageHeight, maxHeight - pageHeight)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
        let newPage = min(currentPage.value + 1, stackView.arrangedSubviews.count - 1)
        currentPage.accept(newPage)
    }

    @objc func prevTapped(_ sender: UIButton) {
        let pageHeight = scrollView.frame.size.height
        let currentOffset = scrollView.contentOffset.y
        let newOffset = max(currentOffset - pageHeight, 0)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
        let newPage = max(currentPage.value - 1, 0)
        currentPage.accept(newPage)
    }
    
    // UITextFieldDelegate 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextTapped(nextButton)
        return true
    }
}

// UIScrollViewDelegate 메서드
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.size.height
        let currentPageDouble = scrollView.contentOffset.y / pageHeight
        let currentPage = Int(currentPageDouble)
        self.currentPage.accept(currentPage)
    }
}
