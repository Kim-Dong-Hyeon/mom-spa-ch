//
//  MenuCollectionViewCell.swift
//  MomSpaCh
//
//  Created by 김윤홍 on 7/3/24.
//

import UIKit

import SnapKit

protocol MenuCollectionViewCellDelegate: AnyObject {
  func addOrderList(_: String, _: String)
}

/// UICollectionViewCell 클래스
class MenuCollectionViewCell: UICollectionViewCell {
  weak var delegate: MenuCollectionViewCellDelegate?
  lazy var menuData = MenuData()
  static let identifier = "cell"
  
  private lazy var menuButton: UIButton = {
    var menuButton = UIButton()
    menuButton.backgroundColor = UIColor(named: "menuButtonBackground")
    return menuButton
  }()
  
  private let priceLabel: UILabel = {
    var priceLabel = UILabel()
    priceLabel.font = UIFont.boldSystemFont(ofSize: 15)
    return priceLabel
  }()
  
  private let nameLabel: UILabel = {
    var nameLabel = UILabel()
    nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    return nameLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    [menuButton, priceLabel, nameLabel].forEach { contentView.addSubview($0) }
    setConstraints()
    menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  /// cell 내용설정
  /// - Parameters:
  ///   - imageName: 사진이름
  ///   - price: 가격
  ///   - name: 이름
  func configure(withImageName imageName: String, price: Int, name: String) {
    if let image = UIImage(named: imageName) {
      menuButton.setTitle(imageName, for: .normal)
      menuButton.setImage(image, for: .normal)
    }
    priceLabel.text = "\(price)원"
    nameLabel.text = name
  }
  
  /// 오토레이아웃 설정
  func setConstraints() {
    menuButton.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(100)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(menuButton.snp.bottom).offset(5)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(15)
      
    }
    
    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(15)
    }
  }
  

  @objc func buttonClicked(sender: UIButton) {
    let price = priceLabel.text!.filter { $0 != "원" && $0 != " "}
    let name = nameLabel.text!
    delegate?.addOrderList(price, name)

  }
}
