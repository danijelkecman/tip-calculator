//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class TipInputView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been initialized")
  }
}

extension TipInputView {
  func setupViews() {
    backgroundColor = .red
  }
}
