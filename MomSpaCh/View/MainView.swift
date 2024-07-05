//
//  MainView.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

import SnapKit

protocol MainViewDelegate: AnyObject {
  func orderListClear()
  func clickedOrderButton()
}

class MainView: UIView {
  weak var delegate: MainViewDelegate?
  private let segmentedControl = UISegmentedControl(items: ["전체", "버거", "치킨", "사이드", "음료"])
  var selectedCategory = "전체"
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
  
  let menuCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .systemBackground
    configureUI()
    logoConstraints()
    setupSegmentedControl()
    setupSegmentedControlConstraints()
    setupCollectionViewConstraint()
    makeTableView()
    tableViewConstraints()
    setupButtonsStackView()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    [logo,segmentedControl, menuCollectionView, stackView, tableView, allCount, payLabel, tableView, orderQuantity, totalAmount].forEach { self.addSubview($0)}
    [productNameLabel, quantityLabel, amount].forEach {stackView.addArrangedSubview($0)}
  }
  
  func logoConstraints() {
    logo.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(40)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top).offset(40)
    }
  }
  
  //segmentControl 파일 분리
  // MARK: - UISegmentedControl (Developer: 김동현)
  
  /// UISegmentedControl을 설정하고 초기 선택 색상을 지정하는 메서드
  private func setupSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = UIColor(
      red: 217/255,
      green: 69/255,
      blue: 81/255,
      alpha: 0.5
    )
    segmentedControl.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
  }
  
  /// setupSegmentedControlConstraints: UISegmentedControl의 제약 조건을 설정하는 메서드
  private func setupSegmentedControlConstraints() {
    segmentedControl.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.top.equalTo(logo.snp.bottom).offset(10)
    }
  }
  
  // View or Controller 정하기
  /// categoryChanged: UISegmentedControl의 값이 변경되었을 때 호출되는 메서드
  /// - Parameter sender: UISegmentedControl
  @objc private func categoryChanged(_ sender: UISegmentedControl) {
    selectedCategory = segmentedControl.titleForSegment(at: sender.selectedSegmentIndex) ?? "전체"
    menuCollectionView.reloadData()
  }
  
  /// 컬렉션뷰 제약조건 설정
  func setupCollectionViewConstraint() {
    menuCollectionView.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(40)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-40)
      $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
      $0.bottom.equalTo(stackView.snp.top).offset(-20)
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
  private func setupButtonsStackView() {
    let cancelButton = createCancelButton()
    let orderButton = createOrderButton()
    let stackView = UIStackView(arrangedSubviews: [cancelButton, orderButton])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10

    self.addSubview(stackView)

    stackView.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(50)
    }
  }

  /// cancelButton과 orderButton을 stackView에 추가 & layout
  private func createOrderButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("주문하기", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "spaColor")
    button.setTitleColor(UIColor(named: "orderButtonTitle"), for: .normal)
    button.layer.cornerRadius = 5
    button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    return button
  }

  /// cancelButton 생성
  /// - Returns: 생성한 버튼 리턴
  private func createCancelButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "cancleButtonBackground")
    button.setTitleColor(UIColor(named: "spaColor"), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(named: "spaColor")?.cgColor
    button.layer.cornerRadius = 5
    button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    return button
  }
  
  /// cancleButton 클릭
  @objc private func cancelButtonTapped() {
    delegate?.orderListClear()
  }
  
  /// orderButton 클릭
  /// 주문내역의 유무에 따른 메세지 표시
  @objc private func orderButtonTapped() {
    delegate?.clickedOrderButton()
  }
}
