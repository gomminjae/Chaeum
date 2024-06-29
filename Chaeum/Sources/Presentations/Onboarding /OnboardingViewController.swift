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
    
   
    
    private let categories: [String] = ["기획,전략", "인사,HR", "회계,세무", "개발,데이터", "디자인", "양업", "금융,보험","건설,건축","생산","복지","연구,R&D","교육","미디어","스포츠","마케팅,홍보"]
 
    private var jobCategoryReactor: JobCategoryReactor!
        
    
    let segmentedProgressBar = SegmentedProgressBar()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupJobCategoryReactor()
        bindReactor(reactor: jobCategoryReactor)
        
    }
    
    private func setupJobCategoryReactor() {
            jobCategoryReactor = JobCategoryReactor(data: categories)
        }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
//        view.addSubview(nextButton)
//        view.addSubview(prevButton)
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
//        
//        nextButton.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            $0.width.equalTo(100)
//            $0.height.equalTo(70)
//            $0.trailing.equalTo(view.snp.centerX).offset(-10)
//        }

//        prevButton.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            $0.width.equalTo(100)
//            $0.height.equalTo(70)
//            $0.leading.equalTo(view.snp.centerX).offset(10)
//        }
//        
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
    
    private func bindReactor(reactor: JobCategoryReactor) {
        reactor.state
            .map { $0.categories }
            .bind(to: jobCategoryView.rx.items(cellIdentifier: "category", cellType: JobCategoryCell.self)) { (index,model,cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        jobCategoryView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                jobCategoryView.rx.itemSelected.map { ($0, true) },
                jobCategoryView.rx.itemDeselected.map { ($0, false) }
            )
            .scan([]) { selected, event in
                var selected = selected
                if event.1 {
                    selected.append(event.0)
                } else {
                    if let index = selected.firstIndex(of: event.0) {
                        selected.remove(at: index)
                    }
                }
                return selected
            }
            .map { JobCategoryReactor.Action.selectedItems($0) }
            .bind(to: reactor.action)
                    .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.selectedItems }
            .distinctUntilChanged()
            .bind(onNext: { [weak self] selectedIndexPaths in
                print(selectedIndexPaths)
                guard let self = self else { return }
                for indexPath in self.jobCategoryView.indexPathsForVisibleItems {
                    if let cell = self.jobCategoryView.cellForItem(at: indexPath) {
                        cell.backgroundColor = selectedIndexPaths.contains(indexPath) ? .white : .contentColor
                    }
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupStackView() {
        
        let headerView = HeaderView()
        let nameView = NameView()
       
        
        
        [nameView,jobCategoryView].forEach { view in
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
    lazy var jobCategoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 15
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(JobCategoryCell.self, forCellWithReuseIdentifier: "category")
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        view.backgroundColor = .clear
        return view
    }()

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

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            header.backgroundColor = .red

            let label = UILabel(frame: header.bounds)
            label.text = "Header"
            header.addSubview(label)

            return header
        }
}
