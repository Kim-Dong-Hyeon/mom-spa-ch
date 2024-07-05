//
//  CustomTableViewCell.swift
//  MomSpaCh
//
//  Created by 백시훈 on 7/3/24.
//

import UIKit

import SnapKit

protocol CustomTableViewCellDelegate: AnyObject {
  func deleteButton(in cell: CustomTableViewCell)
  func plusButtonTap(in cell: CustomTableViewCell)
  func minusButtonTap(in cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
  weak var delegate: CustomTableViewCellDelegate?
  
  let plusButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("+", for: .normal)
    button.backgroundColor = .lightGray
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  let minusButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("-", for: .normal)
    button.backgroundColor = .lightGray
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  let countLabel: UILabel = {
    let label = UILabel()
    label.text = "1"
    label.textAlignment = .center
    return label
  }()
  let itemNameLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textAlignment = .center
    return label
  }()
  let payLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textAlignment = .center
    return label
  }()
  let wonLabel: UILabel = {
    let label = UILabel()
    label.text = "원"
    label.textAlignment = .center
    return label
  }()
  
  /// init : UITabelViewCell 초기화 메서드 재정의
  /// - Parameters:
  ///   - style: UITabelViewCell의 스타일을 지정하는 파라미터
  ///   - reuseIdentifier: UITableViewCell의 재사용 식별자
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(plusButton)
    contentView.addSubview(minusButton)
    contentView.addSubview(countLabel)
    contentView.addSubview(itemNameLabel)
    contentView.addSubview(payLabel)
    contentView.addSubview(wonLabel)
    
    createConstraint()
    
    plusButton.addTarget(self, action: #selector(tappedPlusButton), for: .touchDown)
    minusButton.addTarget(self, action: #selector(tappedMinusButton), for: .touchDown)
  }
  
  ///createConstraint : UI 제약조건 설정
  ///Developer : 백시훈
  private func createConstraint(){
    plusButton.snp.makeConstraints {
      $0.centerX.equalTo(contentView.snp.centerX).offset(-5)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(20)
      $0.width.equalTo(20)
    }
    
    minusButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.centerX.equalTo(contentView.snp.centerX).offset(35)
      $0.height.equalTo(20)
      $0.width.equalTo(20)
    }
    
    countLabel.snp.makeConstraints {
      $0.centerX.equalTo(contentView.snp.centerX).offset(15)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(20)
    }
    itemNameLabel.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(contentView.snp.leading).inset(10)
    }
    
    payLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(minusButton.snp.trailing).offset(20)
    }
    
    wonLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(10)
    }
  }
  
  /// tappedMinusButton : minus버튼 클릭시 이벤트
  /// Developer : 백시훈
  @objc func tappedMinusButton() {
    if let countText = countLabel.text, let count = Int(countText) {
      
      if count != 0 {
        countLabel.text = String(count - 1)
        if let payText = payLabel.text, let pay = Int(payText) {
          if String((pay / count) * (count - 1)) == "0" {
            print("삭제")
            delegate?.deleteButton(in: self)
            
          } else {
            print("정상")
            payLabel.text = String((pay / count) * (count - 1))
          }
          
          delegate?.minusButtonTap(in: self)
        }
      }
    }
  }
  
  /// tappedPlusButton : plus버튼을 클릭했을때 이벤트
  /// Developer : 백시훈
  @objc func tappedPlusButton() {
    if let countText = countLabel.text, let count = Int(countText) {
      countLabel.text = String(count + 1)
      if let payText = payLabel.text, let pay = Int(payText){
        payLabel.text = String((pay / count) * (count + 1))
      }
      delegate?.plusButtonTap(in: self)
    }
  }
  
  /// init? : 디코딩을 위한 초기화 메서드 필수 구현
  /// - Parameter coder: 객체를 인코딩하고 디코딩하는 역할
  required init?(coder: NSCoder) {
    fatalError("Error")
  }
}
