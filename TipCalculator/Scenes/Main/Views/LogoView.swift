//
//  LogoView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class LogoView: UIView {
  private let logoImageview = UIImageView()
  private let horizontalStackView = UIStackView()
  private let verticalStackView = UIStackView()
  private var topLabel = UILabel()
  private var bottomLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LogoView {
  func setupViews() {
    backgroundColor = .bg

    setupHorizontalStackView()
    setupVerticalStackView()
    setupLogoImageView()
    setupTopLabel()
    setupBottomLabel()
  }

  func setupHorizontalStackView() {
    addSubview(horizontalStackView)

    horizontalStackView.axis = .horizontal
    horizontalStackView.spacing = 8
    horizontalStackView.alignment = .center

    horizontalStackView.addArrangedSubview(logoImageview)
    horizontalStackView.addArrangedSubview(verticalStackView)

    horizontalStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
  }

  func setupVerticalStackView() {
    verticalStackView.axis = .vertical
    verticalStackView.spacing = -4

    verticalStackView.addArrangedSubview(topLabel)
    verticalStackView.addArrangedSubview(bottomLabel)
  }

  func setupLogoImageView() {
    logoImageview.image = UIImage(.logo)
    logoImageview.contentMode = .scaleAspectFit

    logoImageview.snp.makeConstraints {
      $0.height.equalTo(logoImageview.snp.width)
    }
  }

  func setupTopLabel() {
    let text = NSMutableAttributedString(
      string: "Mr TIP",
      attributes: [.font: UIFont.custom(type: .demibold, size: 16)])
    // swiftlint:disable:next legacy_constructor
    text.addAttributes([.font: UIFont.custom(type: .bold, size: 24)], range: NSMakeRange(3, 3))
    topLabel.attributedText = text
  }

  func setupBottomLabel() {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    let text = NSMutableAttributedString(
      string: "Calculator",
      attributes: [
        .font: UIFont.custom(type: .demibold, size: 16),
        .paragraphStyle: style
      ])
    bottomLabel.attributedText = text
  }
}
