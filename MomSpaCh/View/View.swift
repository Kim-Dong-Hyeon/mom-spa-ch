//
//  ViewController.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  let logo = UIImageView()
  static let identifier = "mainViewController"
  
  private let segmentedControl = UISegmentedControl(items: ["전체", "버거", "치킨", "사이드", "음료"])
  private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.menuCollectionView.dataSource = self
    self.menuCollectionView.delegate = self
    self.menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    setSegmentedControl()
    setCollectionView()
    setCollectionViewConstraint()
    view.backgroundColor = .white
    logo.image = UIImage(named: "logo")
    logo.contentMode = .scaleAspectFit
    
    view.addSubview(logo)
    
    logo.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(40)
      $0.top.equalToSuperview().inset(60)
      $0.leading.equalToSuperview().inset(20)
    }
  }
  
  private func setSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
  }
  
  func setCollectionView() {
    view.addSubview(menuCollectionView)
  }
  
  func setCollectionViewConstraint() {
    menuCollectionView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(30)
      make.top.equalToSuperview().inset(150)
      make.bottom.equalToSuperview().inset(150) // 추후 tableView로 변경
    }
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 130, height: 130)
  }
}

class MenuCollectionViewCell: UICollectionViewCell {
  let menuData = Data()
  static let identifier = "cell"
  
  private let menuImageView: UIImageView = {
    var cellView = UIImageView()
    return cellView
  }()
  
  private let menuLabel: UILabel = {
    var cellLabel = UILabel()
    return cellLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setimageView()
    setMenuLabel()
    setConstraints()
    
    if let image = menuData.foodMenu["burger"]?.keys.first {
      menuImageView.image = image
    }
    
    if let price = menuData.foodMenu["burger"]?.values.first {
      menuLabel.text = String(price)
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  func setimageView() {
    addSubview(menuImageView)
    menuImageView.backgroundColor = .systemPink
  }
  
  func setMenuLabel() {
    addSubview(menuLabel)
    menuLabel.text = "가격"
    menuLabel.font = UIFont.boldSystemFont(ofSize: 20)
  }
  
  func setConstraints() {
    menuImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview()
    }
    
    menuLabel.snp.makeConstraints { make in
      make.top.equalTo(menuImageView.snp.bottom).offset(10)
      make.leading.equalToSuperview().inset(40)
    }
  }
}
