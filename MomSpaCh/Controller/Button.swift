//
//  ButtonTapped.swift
//  MomSpaCh
//
//  Created by pc on 7/10/24.
//

import UIKit

class AnimationButton: UIButton {
  private var originalTransform: CGAffineTransform = .identity
  
  override var isHighlighted: Bool {
    didSet {
      self.animateHighlight()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.originalTransform = self.transform
  }
  override func didMoveToWindow() {
    super.didMoveToWindow()
    self.originalTransform = self.transform
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func animateHighlight() {
    let animationElement = self.isHighlighted ? Animation.touchDown.element : Animation.touchUp.element
    
    UIView.animate(withDuration: animationElement.duration) {
      self.transform = self.isHighlighted ? self.originalTransform.concatenating(animationElement.scale) : self.originalTransform
      self.alpha = animationElement.alpha
    }
  }
}

private enum Animation {
  struct Element {
    let duration: TimeInterval
    let scale: CGAffineTransform
    let alpha: CGFloat
  }
  
  case touchDown
  case touchUp
  
  var element: Element {
    switch self {
    case .touchDown:
      return Element(
        duration: 0.05,
        scale: .init(scaleX: 0.95, y: 0.95),
        alpha: 0.5
      )
    case .touchUp:
      return Element(
        duration: 0.05,
        scale: .identity,
        alpha: 1
      )
    }
  }
}
