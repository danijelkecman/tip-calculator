//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class TipInputView: UIView {

  let headerView: HeaderView = {
    let headerView = HeaderView()
    headerView.configure(topText: "Choose", bottomText: "your tip")
    return headerView
  }()
  private lazy var tenPercentTipButton: UIButton = {
    return buildTipButton(tip: .tenPercent)
  }()
  private lazy var fifteenPercentTipButton = {
    return buildTipButton(tip: .fifteenPercent)
  }()
  private lazy var twentyPercentTipButton = {
    return buildTipButton(tip: .twentyPercent)
  }()
  private lazy var customPercentTipButton = {
    let button = UIButton()
    button.setTitle("Custom tip", for: .normal)
    button.titleLabel?.font = UIFont.custom(type: .bold, size: 20)
    button.backgroundColor = .primary
    button.tintColor = .white
    button.addCornerRadius(radius: 8.0)
    return button
  }()
  private lazy var buttonHorizontalStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      tenPercentTipButton,
      fifteenPercentTipButton,
      twentyPercentTipButton
    ])
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    stackView.axis = .horizontal
    return stackView
  }()

  private lazy var buttonVerticalStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      buttonHorizontalStackView,
      customPercentTipButton
    ])
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    stackView.axis = .vertical
    return stackView
  }()

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
    setupVerticalStackView()
    setupHeaderView()
  }

  func setupVerticalStackView() {
    addSubview(buttonVerticalStackView)

    buttonVerticalStackView.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
    }
  }

  func setupHeaderView() {
    addSubview(headerView)

    headerView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalTo(buttonVerticalStackView.snp.leading).offset(-24)
      $0.width.equalTo(68)
      $0.centerY.equalTo(buttonHorizontalStackView.snp.centerY)
    }
  }
}

extension TipInputView {
  private func buildTipButton(tip: Tip) -> UIButton {
    let button = UIButton(type: .custom)
    button.backgroundColor = .primary
    button.tintColor = .white
    button.addCornerRadius(radius: 8.0)
    let text = NSMutableAttributedString(
      string: tip.stringValue,
      attributes: [.font: UIFont.custom(type: .bold, size: 20), .foregroundColor: UIColor.white]
    )
    // swiftlint:disable:next legacy_constructor
    text.addAttributes([.font: UIFont.custom(type: .demibold, size: 14)], range: NSMakeRange(2, 1))
    button.setAttributedTitle(text, for: .normal)
    return button
  }
}
