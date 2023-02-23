//
//  CalculatorContentView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class CalculatorContentView: UIView {
  let containerView = UIView()
  let logoView = LogoView()
  let resultView = ResultView()
  let billInputView = BillInputView()
  let tipInputView = TipInputView()
  let splitInputView = SplitInputView()
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      logoView,
      resultView,
      billInputView,
      tipInputView,
      splitInputView,
      UIView()
    ])
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension CalculatorContentView {
  func setupViews() {
    backgroundColor = UIColor.bg
    
    setupContainerView()
    setupStackView()
  }
  
  func setupContainerView() {
    addSubview(containerView)
    
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func setupStackView() {
    containerView.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.leading.equalTo(self.snp.leadingMargin).offset(16)
      $0.trailing.equalTo(self.snp.trailingMargin).offset(-16)
      $0.bottom.equalTo(self.snp.bottomMargin).offset(-16)
      $0.top.equalTo(self.snp.topMargin).offset(16)
    }
    logoView.snp.makeConstraints { $0.height.equalTo(48) }
    resultView.snp.makeConstraints { $0.height.equalTo(224) }
    billInputView.snp.makeConstraints { $0.height.equalTo(56) }
    tipInputView.snp.makeConstraints { $0.height.equalTo(128) }
    splitInputView.snp.makeConstraints { $0.height.equalTo(56) }
  }
}


