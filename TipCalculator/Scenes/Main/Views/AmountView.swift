//
//  AmountView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/25/23.
//

import UIKit
import SnapKit

class AmountView: UIView {
  let title: String
  let textAlignment: NSTextAlignment
  let stackView = UIStackView()
  let titleLabel = UILabel()
  let amountLabel = UILabel()

  init(title: String, textAlignment: NSTextAlignment) {
    self.title = title
    self.textAlignment = textAlignment
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not beeen initialized")
  }

  func setupViews() {
    backgroundColor = .white

    setupStackView()
    setupTitleLabel()
    setupAmountLabel()
  }

  func setupStackView() {
    addSubview(stackView)

    stackView.axis = .vertical
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(amountLabel)

    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func setupTitleLabel() {
    titleLabel.text = title
    titleLabel.textAlignment = textAlignment
    titleLabel.font = UIFont.custom(type: .regular, size: 18)
    titleLabel.textColor = .text
  }

  func setupAmountLabel() {
    amountLabel.textAlignment = textAlignment
    amountLabel.textColor = .primary
    let text = NSMutableAttributedString(string: "$0", attributes: [.font: UIFont.custom(type: .bold, size: 24)])
    // swiftlint:disable:next legacy_constructor
    text.addAttributes([.font: UIFont.custom(type: .bold, size: 16)], range: NSMakeRange(0, 1))
    amountLabel.attributedText = text
  }
}
