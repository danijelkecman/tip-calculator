//
//  HeaderView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 5/7/23.
//

import UIKit
import SnapKit

class HeaderView: UIView {
  let topLabel = UILabel()
  let bottomLabel = UILabel()
  let topSpacerView = UIView()
  let bottomSpacerView = UIView()
  let stackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(topText: String, bottomText: String) {
    self.topLabel.text = topText
    self.bottomLabel.text = bottomText
  }

  func setupViews() {
    backgroundColor = .bg

    setupStackView()
    setupTopLabel()
    setupBottomLabel()
    setupTopSpacerView()
    setupBottomSpacerView()
  }

  func setupStackView() {
    addSubview(stackView)

    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = -4

    stackView.addArrangedSubview(topSpacerView)
    stackView.addArrangedSubview(topLabel)
    stackView.addArrangedSubview(bottomLabel)
    stackView.addArrangedSubview(bottomSpacerView)

    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func setupTopLabel() {
    topLabel.text = nil
    topLabel.font = UIFont.custom(type: .bold, size: 18)
  }

  func setupBottomLabel() {
    bottomLabel.text = nil
    bottomLabel.font = UIFont.custom(type: .regular, size: 16)
  }

  func setupTopSpacerView() {
    topSpacerView.snp.makeConstraints {
      $0.height.equalTo(bottomSpacerView)
    }
  }

  func setupBottomSpacerView() {

  }
}
