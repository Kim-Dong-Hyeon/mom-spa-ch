//
//  MainView.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

import SnapKit

class MainView: UIView {
  var selectedCategory = "all"
  let allCount = UILabel()
  let amount = UILabel()
  let payLabel = UILabel()
  let productNameLabel = UILabel()
  let quantityLabel = UILabel()
  let tableView = UITableView()
  let orderQuantity = UILabel()
  let stackView = UIStackView()
  let totalAmount = UILabel()
  
  let logo : UIImageView = {
    let logo = UIImageView()
    logo.image = UIImage(named: "logo")
    logo.contentMode = .scaleAspectFit
    return logo
  }()
  
  let searchTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "메뉴 검색"
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  let clearButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
    button.tintColor = UIColor(named: "spaColor")
    return button
  }()
  
  let searchButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    button.tintColor = UIColor(named: "spaColor")
    return button
  }()
  
  let showNextMenu: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.transform = CGAffineTransform(scaleX: 2, y: 2)
    button.tintColor = UIColor(named: "spaColor")
    return button
  }()
  
  let showPreviousMenu: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.transform = CGAffineTransform(scaleX: 2, y: 2)
    button.tintColor = UIColor(named: "spaColor")
    return button
  }()
  
  let pageControl: UIPageControl = {
    let pagecontrol = UIPageControl()
    pagecontrol.pageIndicatorTintColor = .lightGray
    pagecontrol.currentPageIndicatorTintColor = UIColor(named: "spaColor")
    pagecontrol.numberOfPages = 8
    return pagecontrol
  }()
  
  let segmentedControl = UISegmentedControl(items: ["전체", "버거", "치킨", "사이드", "음료"])
  
  let menuCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    return stackView
  }()
  
  var orderButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("주문하기", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "spaColor")
    button.setTitleColor(UIColor(named: "orderButtonTitle"), for: .normal)
    button.layer.cornerRadius = 5
    return button
  }()
  
  var cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "cancleButtonBackground")
    button.setTitleColor(UIColor(named: "spaColor"), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(named: "spaColor")?.cgColor
    button.layer.cornerRadius = 5
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .systemBackground
    configureUI()
    logoConstraints()
    setupSearchConstraints()
    setupSegmentedControl()
    setupSegmentedControlConstraints()
    setupCollectionViewConstraint()
    setupPagingButtonConstraints()
    setupPagingControlConstraints()
    makeTableView()
    tableViewConstraints()
    setupButtonsStackViewConstraint()
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    [logo, searchTextField, clearButton, searchButton, segmentedControl, menuCollectionView, stackView, tableView, allCount, payLabel, tableView, orderQuantity, totalAmount, showNextMenu, showPreviousMenu, pageControl, buttonStackView].forEach { self.addSubview($0)}
    [productNameLabel, quantityLabel, amount].forEach {stackView.addArrangedSubview($0)}
    [cancelButton, orderButton].forEach {buttonStackView.addArrangedSubview($0)}
  }
  
  func logoConstraints() {
    logo.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(40)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top).offset(40)
    }
  }
  
  func setupSearchConstraints() {
    searchTextField.snp.makeConstraints {
      $0.leading.equalTo(logo.snp.trailing).offset(10)
      $0.centerY.equalTo(logo.snp.centerY)
      $0.height.equalTo(40)
    }
    
    searchButton.snp.makeConstraints {
      $0.leading.equalTo(searchTextField.snp.trailing).offset(10)
      $0.centerY.equalTo(searchTextField.snp.centerY)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
    }
  }
  
  //segmentControl 파일 분리
  // MARK: - UISegmentedControl (Developer: 김동현)
  
  /// UISegmentedControl을 설정하고 초기 선택 색상을 지정하는 메서드
  private func setupSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = UIColor(named: "spaColor")
  }
  
  /// setupSegmentedControlConstraints: UISegmentedControl의 제약 조건을 설정하는 메서드
  private func setupSegmentedControlConstraints() {
    segmentedControl.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.top.equalTo(logo.snp.bottom).offset(10)
    }
  }
  
  /// 컬렉션뷰 제약조건 설정
  func setupCollectionViewConstraint() {
    menuCollectionView.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(40)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-40)
      $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
      $0.bottom.equalTo(pageControl.snp.top)
    }
  }
  
  func setupPagingButtonConstraints() {
    showNextMenu.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.leading.equalTo(menuCollectionView.snp.trailing)
      $0.top.equalToSuperview().inset(350)
    }
    
    showPreviousMenu.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalTo(menuCollectionView.snp.leading)
      $0.top.equalToSuperview().inset(350)
    }
  }
  
  func setupPagingControlConstraints() {
    pageControl.snp.makeConstraints {
      $0.top.equalTo(menuCollectionView.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(stackView.snp.top)
    }
  }
  
  func makeTableView() {
    tableView.layer.borderWidth = 1.0
    tableView.layer.borderColor = UIColor.red.cgColor
    tableView.rowHeight = 44
    allCount.layer.borderWidth = 1.0
    allCount.layer.borderColor = UIColor.red.cgColor
    allCount.textAlignment = .center
    allCount.text = "0"
    payLabel.text = "0"
    payLabel.adjustsFontSizeToFitWidth = true
    payLabel.layer.borderWidth = 1.0
    payLabel.textAlignment = .center
    payLabel.layer.borderColor = UIColor.red.cgColor
    
    productNameLabel.text = "제품명"
    quantityLabel.text = "수량"
    amount.text = "금액"
    orderQuantity.text = "주문수량"
    totalAmount.text = "합계금액"
    stackView.spacing = 70
  }
  
  func tableViewConstraints() {
    tableView.snp.makeConstraints {
      $0.height.equalTo(130)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-90)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(60)
    }
    
    allCount.snp.makeConstraints {
      $0.leading.equalTo(tableView.snp.trailing).offset(10)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.centerY.equalTo(tableView.snp.top).offset(15)
      $0.height.equalTo(30)
      $0.width.equalTo(60)
    }
    payLabel.snp.makeConstraints {
      $0.leading.equalTo(tableView.snp.trailing).offset(10)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.centerY.equalTo(tableView.snp.top).offset(90)
      $0.height.equalTo(30)
      $0.width.equalTo(60)
    }
    stackView.snp.makeConstraints {
      $0.bottom.equalTo(tableView.snp.top).offset(-10)
      $0.centerX.equalTo(tableView.snp.centerX)
    }
    orderQuantity.snp.makeConstraints {
      $0.bottom.equalTo(allCount.snp.top).offset(-10)
      $0.centerX.equalTo(allCount.snp.centerX)
    }
    totalAmount.snp.makeConstraints {
      $0.bottom.equalTo(payLabel.snp.top).offset(-10)
      $0.centerX.equalTo(payLabel.snp.centerX)
    }
  }
  
  // MARK: - UIStackView (Developer: 최건)
  
  /// cancelButton과 orderButton을 stackView에 추가 & layout
  func setupButtonsStackViewConstraint() {
    buttonStackView.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(50)
    }
  }
}


