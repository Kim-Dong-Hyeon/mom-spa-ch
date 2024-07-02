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

  override func viewDidLoad() {
    super.viewDidLoad()

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

}

