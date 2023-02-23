//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class SplitInputView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been initialized")
  }
}

extension SplitInputView {
  func setupViews() {
    backgroundColor = .blue
  }
}
