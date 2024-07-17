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
    
    
    var coordinator: OnboardingCoordinator?
    
    private let disposeBag = DisposeBag()
    
    private var jobCategoryReactor: JobCategoryReactor?
    
    
    //let segmentedProgressBar = SegmentedProgressBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobCategoryView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        if let reactor = jobCategoryReactor {
            bindReactor(reactor: reactor)
        }
        
    }
    
    init() {
        let repository = JobCategoryRepositoryImpl()
        let reactor = JobCategoryReactor(repository: repository)
        self.jobCategoryReactor = reactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
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
        
    }
    
    override func bindRX() {
        
        worryView.addButton.rx.tap
                   .subscribe(onNext: { [weak self] in
                       //self?.coordinator?.presentWorry()
                       self?.present(AddWorryViewController(), animated: true)
                       print("Button tapped")
                   })
                   .disposed(by: disposeBag)
        completeView.completeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                print("Hello")
            })
            .disposed(by: disposeBag)
    }
    
    private func bindReactor(reactor: JobCategoryReactor) {
        
        jobCategoryView.rx.itemSelected
            .map { JobCategoryReactor.Action.selectItem($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        jobCategoryView.rx.itemDeselected
            .map { JobCategoryReactor.Action.deselectItem($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.categories }
            .bind(to: jobCategoryView.rx.items(cellIdentifier: "category", cellType: JobCategoryCell.self)) { (index, model, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { Array($0.selectedItems) }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] selectedItems in
                guard let self = self else { return }
                self.jobCategoryView.reloadData()
                DispatchQueue.main.async {
                    self.updateSelectedCells(selectedItems)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func updateSelectedCells(_ selectedItems: [IndexPath]) {
        let allIndexPaths = Set((0..<jobCategoryView.numberOfSections).flatMap { section in
            (0..<jobCategoryView.numberOfItems(inSection: section)).map { IndexPath(item: $0, section: section) }
        })
        
        let selectedIndexPaths = Set(selectedItems)
        let unselectedIndexPaths = allIndexPaths.subtracting(selectedIndexPaths)
        
        selectedIndexPaths.forEach { indexPath in
            if let cell = jobCategoryView.cellForItem(at: indexPath) as? JobCategoryCell {
                cell.isSelected = true
            }
        }
        
        unselectedIndexPaths.forEach { indexPath in
            if let cell = jobCategoryView.cellForItem(at: indexPath) as? JobCategoryCell {
                cell.isSelected = false
            }
        }
    }
    private func setupStackView() {
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(jobCategoryView)
        stackView.addArrangedSubview(worryView)
        stackView.addArrangedSubview(completeView)
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        jobCategoryView.snp.makeConstraints {
            $0.height.equalTo(250)
            $0.left.right.equalTo(view).inset(20)
        }
        worryView.snp.makeConstraints {
            $0.height.equalTo(self.view.frame.height)
            
        }
        completeView.snp.makeConstraints {
            $0.height.equalTo(80)
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
    
    lazy var startButton = UIButton().then {
        $0.backgroundColor = .green
        $0.setTitle("시작하기", for: .normal)
        $0.isHidden = true
    }
    
    
    let headerView = HeaderView()
    let nameView = NameView()
    lazy var jobCategoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 1
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(JobCategoryCell.self, forCellWithReuseIdentifier: "category")
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        view.backgroundColor = .contentColor
        view.layer.cornerRadius = 15
        view.isScrollEnabled = false
        view.allowsMultipleSelection = true
        return view
    }()
    let worryView = WorryCategoryView()
        let completeView = CompleteView()
    

}


extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        header.backgroundColor = .clear
        
        let label = UILabel(frame: header.bounds)
        label.text = "Header"
        label.textColor = .white
        
        header.addSubview(label)
        
        return header
    }
}
