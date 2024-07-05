//
//  ViewController.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                        CustomTableViewCellDelegate, UICollectionViewDelegate,
                      MenuCollectionViewCellDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout {
  let menuData = MenuData()
  private let tableView = UITableView()
  static let identifier = "mainViewController"
  private let allCount = UILabel()
  private let button = UIButton()
  private let countLabel = UILabel()
  // CodeConvention 재확인 필요
  private let menuCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private let nameLabel = UILabel()
  private let payLabel = UILabel()
  private let productNameLabel = UILabel()
  private let quantityLabel = UILabel()
  private let amount = UILabel()
  private let orderQuantity = UILabel()
  private let totalAmount = UILabel()
  private let stackView = UIStackView()
  private let scrollView = UIScrollView()
  private let segmentedControl = UISegmentedControl(items: ["전체", "버거", "치킨", "사이드", "음료"])
  let logo : UIImageView = {
    let logo = UIImageView()
    logo.image = UIImage(named: "logo")
    logo.contentMode = .scaleAspectFit
    return logo
  }()
  var selectedCategory = "전체"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    [logo, segmentedControl, scrollView, allCount, payLabel, menuCollectionView].forEach {
      view.addSubview( $0 )
    }
    
    logo.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(40)
      $0.top.equalToSuperview().inset(60)
      $0.leading.equalToSuperview().inset(20)
    }
    
    setupTableView()
    setupSegmentedControl()
    setupCollectionView()
    setupCollectionViewConstraint()
    setupSegmentedControlConstraints()
    setupButtonsStackView()
  }
  
  // Model 이동 예정
  var nameData: [String] = []
  var priceData: [Int] = []
  var countData: [Int] = []
  var checkDuplication: Bool = false
  func addOrderList(_ pay: String, _ name: String){
    if nameData.contains(name){
      checkDuplication = true//중복일때
      for i in 0..<nameData.count{
        if nameData[i] == name{
          countData[i] += 1
          priceData[i] += Int(pay)!
        }
      }
      print(countData.reduce(0, +))
      allCount.text = String(countData.reduce(0, +))
    }else{
      checkDuplication = false
      nameData.append(name)
      priceData.append(Int(pay)!)
      countData.append(1)
    }
    allCount.text = String(countData.reduce(0, +))
    payLabel.text = String(priceData.reduce(0, +))
    tableView.reloadData()
  }
  
  /// setSegmentedControl: UISegmentedControl을 설정하고 초기 선택 색상을 지정하는 메서드
  private func setupSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = UIColor(red: 217/255, green: 69/255, blue: 81/255, alpha: 0.5)
    segmentedControl.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
  }
  
  /// setupSegmentedControlConstraints: UISegmentedControl의 제약 조건을 설정하는 메서드
  private func setupSegmentedControlConstraints() {
    segmentedControl.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(logo.snp.bottom).offset(20)
    }
  }
  
  // View or Controller 정하기
  /// categoryChanged: UISegmentedControl의 값이 변경되었을 때 호출되는 메서드
  /// - Parameter sender: UISegmentedControl
  @objc private func categoryChanged(_ sender: UISegmentedControl) {
    selectedCategory = segmentedControl.titleForSegment(at: sender.selectedSegmentIndex) ?? "전체"
    menuCollectionView.reloadData()
  }
  
  // Constraints 묶어야 함
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.layer.borderWidth = 1.0
    tableView.layer.borderColor = UIColor.red.cgColor
    allCount.layer.borderWidth = 1.0
    allCount.layer.borderColor = UIColor.red.cgColor
    allCount.textAlignment = .center
    allCount.text = ""
    payLabel.text = ""
    payLabel.adjustsFontSizeToFitWidth = true
    payLabel.layer.borderWidth = 1.0
    payLabel.textAlignment = .center
    payLabel.layer.borderColor = UIColor.red.cgColor
    
    productNameLabel.text = "제품명"
    quantityLabel.text = "수량"
    amount.text = "금액"
    orderQuantity.text = "주문수량"
    totalAmount.text = "합계금액"
    stackView.addArrangedSubview(productNameLabel)
    stackView.addArrangedSubview(quantityLabel)
    stackView.addArrangedSubview(amount)
    stackView.spacing = 70
    view.addSubview(tableView)
    view.addSubview(allCount)
    view.addSubview(payLabel)
    view.addSubview(stackView)
    view.addSubview(orderQuantity)
    view.addSubview(totalAmount)
    
    tableView.snp.makeConstraints {
      $0.height.equalTo(130)
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(100)
      $0.trailing.equalToSuperview().inset(80)
    }
    allCount.snp.makeConstraints {
      $0.leading.equalTo(tableView.snp.trailing).offset(10)
      $0.centerY.equalTo(tableView.snp.top).offset(15)
      $0.height.equalTo(30)
      $0.width.equalTo(60)
    }
    payLabel.snp.makeConstraints {
      $0.leading.equalTo(tableView.snp.trailing).offset(10)
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
    
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell") // 셀 등록
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nameData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
      return UITableViewCell()
    }
    cell.itemNameLabel.text = nameData[indexPath.row]
    
    cell.countLabel.text = String(countData[indexPath.row])
    
    
    cell.plusButton.tag = indexPath.row
    cell.minusButton.tag = indexPath.row
    cell.payLabel.text = String(priceData[indexPath.row])
    cell.delegate = self
    return cell
  }
  
  func deleteButton(in cell: CustomTableViewCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      print(indexPath.row)
      nameData.remove(at: indexPath.row)
      priceData.remove(at: indexPath.row)
      countData.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      allCount.text = String(countData.reduce(0, +))
      payLabel.text = String(priceData.reduce(0, +))
    }
  }
  
  /// 컬렉션뷰 만들기
  func setupCollectionView() {
    self.menuCollectionView.dataSource = self
    self.menuCollectionView.delegate = self
    // CodeConvention 재확인 필요
    self.menuCollectionView.register(
      MenuCollectionViewCell.self,
      forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
    )
    view.addSubview(menuCollectionView)
  }
  
  /// 컬렉션뷰 제약조건 설정
  func setupCollectionViewConstraint() {
    menuCollectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(30)
      $0.top.equalToSuperview().inset(150)
      $0.bottom.equalToSuperview().inset(300) // 추후 tableView로 변경
    }
  }
  
  /// 컬렉션뷰 셀을 컬렉션 뷰 않에 넣기
  /// - Parameters:
  ///   - collectionView: 넣어야할 컬렉션뷰
  ///   - indexPath: cell indextPath
  /// - Returns: 다운캐스팅 실패시 기본셀 리턴
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    //    var menuItems: [String]
    switch selectedCategory {
    case "버거":
      let burgerItem = menuData.menuArray.filter {$0.category == "burger"}
      let item = burgerItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
      
    case "치킨":
      let chickenItem = menuData.menuArray.filter {$0.category == "chicken"}
      let item = chickenItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
      
    case "사이드":
      let sideMenuItem = menuData.menuArray.filter {$0.category == "sideMenu"}
      let item = sideMenuItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
      
    case "음료":
      let drinkItem = menuData.menuArray.filter {$0.category == "drink"}
      let item = drinkItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
      
    default:
      let item = menuData.menuArray[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
    }
    cell.delegate = self
    return cell
  }
  
  /// collectionView 제약 조건
  /// - Returns: 사이즈
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 130, height: 170)
  }
  
  
  /// 컬렉션 뷰 내부 셀구성 개수 설정
  /// - Returns: 개수
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch selectedCategory {
    case "버거":
      return menuData.menuArray.filter{ $0.category == "burger"}.count
    case "치킨":
      return menuData.menuArray.filter{ $0.category == "chicken"}.count
    case "사이드":
      return menuData.menuArray.filter{ $0.category == "sideMenu"}.count
    case "음료":
      return menuData.menuArray.filter{ $0.category == "drink"}.count
    default:
      return menuData.menuArray.count
    }
  }
  
  func plusButtonTap(in cell: CustomTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    var sum = 0
    var paySum = 0
    
    if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell,
       let countText = cell.itemNameLabel.text{
      print(countText)
      for i in 0..<nameData.count{
        if nameData[i] == countText{
          let count = Int(countData[i])
          countData[i] += 1
          sum = countData.reduce(0, +)
          print(countData)
          priceData[i] = (priceData[i] / count) * (count + 1)
          paySum = priceData.reduce(0, +)
        }
      }
    }
    
    allCount.text = String(sum)
    payLabel.text = String(paySum)
  }
  
  func minusButtonTap(in cell: CustomTableViewCell) {
    var sum = 0
    var paySum = 0
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    print(indexPath.row)
    if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell,
       let countText = cell.itemNameLabel.text{
      
      for i in 0..<nameData.count{
        if nameData[i] == countText{
          let count = Int(countData[i])
          countData[i] -= 1
          sum = countData.reduce(0, +)
          priceData[i] = (priceData[i] / count) * (count - 1)
          paySum = priceData.reduce(0, +)
        }
      }
      
      allCount.text = String(sum)
      payLabel.text = String(paySum)
    }
    
    
  }
  
  private func setupButtonsStackView() {
    let cancelButton = createCancelButton()
    let orderButton = createOrderButton()
    
    let stackView = UIStackView(arrangedSubviews: [cancelButton, orderButton])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(50)
    }
  }
  
  private func createOrderButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("주문하기", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "signatureColor")
    button.setTitleColor(UIColor(named: "orderButtonTitle"), for: .normal)
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    return button
  }
  
  private func createCancelButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(named: "cancleButtonBackground")
    button.setTitleColor(UIColor(named: "signatureColor"), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(named: "signatureColor")?.cgColor
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    return button
  }
  func orderListClear() {
    nameData = []
    priceData = []
    countData = []
    allCount.text = ""
    payLabel.text = ""
    tableView.reloadData()
  }
  @objc private func cancelButtonTapped() {
    orderListClear()
  }
  
  @objc private func orderButtonTapped() {
    if nameData.isEmpty {
      let emptyAlert = UIAlertController(title: "주문내역을 확인해 주십시오", message: "", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
      emptyAlert.addAction(okAction)
      present(emptyAlert, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "최종 결제 금액 \(payLabel.text!)원입니다. 주문하시겠습니까?", message: "", preferredStyle: .alert)
      let yesAction = UIAlertAction(title: "네", style: .default) { _ in
        self.orderCompletedAlert()
      }
      let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
      alert.addAction(yesAction)
      alert.addAction(noAction)
      
      present(alert, animated: true, completion: nil)
    }
  }
  
  private func orderCompletedAlert() {
    let completedAlert = UIAlertController(title: "주문 완료되었습니다.", message: "", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    completedAlert.addAction(okAction)
    orderListClear()
    present(completedAlert, animated: true, completion: nil)
  }
}
