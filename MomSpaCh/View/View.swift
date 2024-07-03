//
//  ViewController.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomTableViewCellDelegate {
  let menuData = Data()
  private let tableView = UITableView()
  private let scrollView = UIScrollView()
  private let button = UIButton()
  private let nameLabel = UILabel()
  private let countLabel = UILabel()
  private let payLabel = UILabel()
  private let allCount = UILabel()
  let logo = UIImageView()
  static let identifier = "mainViewController"
  
  private let segmentedControl = UISegmentedControl(items: ["전체", "버거", "치킨", "사이드", "음료"])
  private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  var test = "0"
  var selectedCategory = "전체"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .systemBackground
    
    createTableView()
    
    self.menuCollectionView.dataSource = self
    self.menuCollectionView.delegate = self
    self.menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    setSegmentedControl()
    setCollectionView()
    setCollectionViewConstraint()
    logo.image = UIImage(named: "logo")
    logo.contentMode = .scaleAspectFit
    
    view.addSubview(logo)
    view.addSubview(segmentedControl)
    
    logo.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(40)
      $0.top.equalToSuperview().inset(60)
      $0.leading.equalToSuperview().inset(20)
    }
    
    setSegmentedControlConstraints()
    
  }
  var data: [String] = []
  
  @objc func testMethod(){
    test = String( Int(test)! + 1 )
    data.append(test)
    print(data)
    tableView.reloadData()
    
  }
  
  /// setSegmentedControl: UISegmentedControl을 설정하고 초기 선택 색상을 지정하는 메서드
  private func setSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
//    segmentedControl.backgroundColor = UIColor(red: 217/255, green: 69/255, blue: 81/255, alpha: 0.5)
//    segmentedControl.selectedSegmentTintColor = UIColor.white
    segmentedControl.selectedSegmentTintColor = UIColor(red: 217/255, green: 69/255, blue: 81/255, alpha: 0.5)
    segmentedControl.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
    view.addSubview(segmentedControl)
  }
  
  /// setSegmentedControlConstraints: UISegmentedControl의 제약 조건을 설정하는 메서드
  private func setSegmentedControlConstraints() {
    segmentedControl.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(logo.snp.bottom).offset(20)
    }
  }
  
  /// categoryChanged: UISegmentedControl의 값이 변경되었을 때 호출되는 메서드
  /// - Parameter sender: UISegmentedControl
  @objc private func categoryChanged(_ sender: UISegmentedControl) {
    selectedCategory = segmentedControl.titleForSegment(at: sender.selectedSegmentIndex) ?? "전체"
    menuCollectionView.reloadData()
  }
  
  func createTableView(){
    
    tableView.backgroundColor = .blue
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    scrollView.backgroundColor = .brown
    allCount.backgroundColor = .yellow
    allCount.text = "test1"
    payLabel.text = "test2"
    payLabel.backgroundColor = .yellow
    view.addSubview(scrollView)
    view.addSubview(allCount)
    view.addSubview(payLabel)
    
    scrollView.snp.makeConstraints {
      $0.height.equalTo(180)
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(70)
      $0.trailing.equalToSuperview().inset(100)
    }
    allCount.snp.makeConstraints {
      $0.leading.equalTo(scrollView.snp.trailing).offset(10)
      $0.centerY.equalTo(scrollView.snp.top).offset(20)
    }
    payLabel.snp.makeConstraints {
      $0.leading.equalTo(scrollView.snp.trailing).offset(10)
      $0.centerY.equalTo(scrollView.snp.top).offset(80)
    }
    // 테이블 뷰 설정
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell") // 셀 등록
    
    // 테이블 뷰 ScrollView에 추가 및 SnapKit을 사용한 제약 조건 설정
    scrollView.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
      return UITableViewCell()
    }
    cell.itemNameLabel.text = data[indexPath.row]
    cell.countLabel.text = "1"
    cell.plusButton.tag = indexPath.row
    cell.minusButton.tag = indexPath.row
    cell.payLabel.text = "10000"
    cell.delegate = self
    return cell
  }
  
  func didTapDeleteButton(in cell: CustomTableViewCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      print(indexPath.row)
      data.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func setCollectionView() {
    view.addSubview(menuCollectionView)
  }
  
  func setCollectionViewConstraint() {
    menuCollectionView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(30)
      make.top.equalToSuperview().inset(150)
      make.bottom.equalToSuperview().inset(300) // 추후 tableView로 변경
    }
  }
  
  func sumCountLabel(in cell: CustomTableViewCell) {
    var sum = 0
    for row in 0..<data.count {
      if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomTableViewCell,
         let countText = cell.countLabel.text, let count = Int(countText) {
        sum += count
      }
    }
    allCount.text = String(sum)
  }
  
  func sumPayLabel(in cell: CustomTableViewCell) {
    var sum = 0
    for row in 0..<data.count {
      if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomTableViewCell,
         let countText = cell.payLabel.text, let count = Int(countText) {
        sum += count
      }
    }
    payLabel.text = String(sum)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }
    return cell
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (menuData.foodMenu["burger"]?.keys.count)!
  }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 130, height: 130)
  }
}
