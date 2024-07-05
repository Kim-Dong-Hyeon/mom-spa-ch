//
//  Controller.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

class ViewController: UIViewController {
  private var mainView: MainView!
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView = MainView(frame: self.view.frame)
    view.backgroundColor = .systemBackground
    self.view.addSubview(mainView)
  }
}
