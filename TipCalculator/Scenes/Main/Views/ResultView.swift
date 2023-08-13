//
//  ResultView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class ResultView: UIView {
  let headerLabel = UILabel()
  let amountPerPersonLabel = UILabel()
  let horizontalLineView = UIView()
  let verticalStackView = UIStackView()
  let horizontalStackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(result: CalculatorResult) {
    let text = NSMutableAttributedString(
      string: result.amountPerson.currencyFormatted,
      attributes: [.font: UIFont.custom(type: .bold, size: 48)])
    text.addAttributes([.font: UIFont.custom(type: .bold, size: 24)], range: NSRange(location: 0, length: 1))
    amountPerPersonLabel.attributedText = text
    totalBillView.configure(amount: result.totalBill)
    totalTipView.configure(amount: result.totalTip)
  }
  
  private let totalBillView: AmountView = {
    let view = AmountView(title: "Total bill", textAlignment: .left)
    return view
  }()
  
  private let totalTipView: AmountView = {
    let view = AmountView(title: "Total tip", textAlignment: .right)
    return view
  }()
}

extension ResultView {
  func setupViews() {
    backgroundColor = .white

    setupVerticalStackView()
    setupHorizontalStackView()
    setupHeaderLabel()
    setupAmountPerPersonLabel()
    setupHorzontalLineView()
  }

  func setupVerticalStackView() {
    addSubview(verticalStackView)

    verticalStackView.axis = .vertical
    verticalStackView.spacing = 8

    verticalStackView.addArrangedSubview(headerLabel)
    verticalStackView.addArrangedSubview(amountPerPersonLabel)
    verticalStackView.addArrangedSubview(horizontalLineView)
    let spacerView = UIView()
    spacerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    verticalStackView.addArrangedSubview(spacerView)
    verticalStackView.addArrangedSubview(horizontalStackView)

    verticalStackView.snp.makeConstraints {
      $0.top.equalTo(snp.top).offset(24)
      $0.leading.equalTo(snp.leading).offset(24)
      $0.trailing.equalTo(snp.trailing).offset(-24)
      $0.bottom.equalTo(snp.bottom).offset(-24)
    }

    addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
  }

  func setupHorizontalStackView() {
    horizontalStackView.axis = .horizontal
    horizontalStackView.distribution = .fillEqually

    horizontalStackView.addArrangedSubview(totalBillView)
    horizontalStackView.addArrangedSubview(UIView())
    horizontalStackView.addArrangedSubview(totalTipView)
  }

  func setupHeaderLabel() {
    headerLabel.text = "Total p/person"
    headerLabel.font = UIFont.custom(type: .demibold, size: 18)
  }

  func setupAmountPerPersonLabel() {
    amountPerPersonLabel.textAlignment = .center
    let text = NSMutableAttributedString(string: "$0", attributes: [.font: UIFont.custom(type: .bold, size: 48)])
    // swiftlint:disable:next legacy_constructor
    text.addAttributes([.font: UIFont.custom(type: .bold, size: 24)], range: NSMakeRange(0, 1))
    amountPerPersonLabel.attributedText = text
  }

  func setupHorzontalLineView() {
    horizontalLineView.backgroundColor = .separator

    horizontalLineView.snp.makeConstraints {
      $0.height.equalTo(2)
    }
  }
}
