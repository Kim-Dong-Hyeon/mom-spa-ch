//
//  ButtonTapped.swift
//  MomSpaCh
//
//  Created by pc on 7/10/24.
//

import UIKit

public protocol AnimationButtonDelegate: AnyObject {
  func didChangeHighlighted(highlighted: Bool)
}

class AnimationButton: UIButton {
  weak var delegate: AnimationButtonDelegate?
  override var isHighlighted: Bool {
    didSet {
      self.delegate?.didChangeHighlighted(highlighted: self.isHighlighted)
    }
  }
}
