//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit
import Combine

class TipInputView: UIView {

  let headerView: HeaderView = {
    let headerView = HeaderView()
    headerView.configure(topText: "Choose", bottomText: "your tip")
    return headerView
  }()
  private lazy var tenPercentTipButton: UIButton = {
    let button = buildTipButton(tip: .tenPercent)
    button.tapPublisher.flatMap {
      Just(Tip.tenPercent)
    }.assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return button
  }()
  private lazy var fifteenPercentTipButton = {
    let button = buildTipButton(tip: .fifteenPercent)
    button.tapPublisher.flatMap {
      Just(Tip.fifteenPercent)
    }.assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return button
  }()
  private lazy var twentyPercentTipButton = {
    let button = buildTipButton(tip: .twentyPercent)
    button.tapPublisher.flatMap {
      Just(Tip.twentyPercent)
    }.assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return button
  }()
  private lazy var customTipButton = {
    let button = UIButton()
    button.setTitle("Custom tip", for: .normal)
    button.titleLabel?.font = UIFont.custom(type: .bold, size: 20)
    button.backgroundColor = .primary
    button.tintColor = .white
    button.tapPublisher.sink { [weak self] _ in
      guard let self else { return }
      handleCustomTipButton()
    }.store(in: &cancellables)
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
      customTipButton
    ])
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    stackView.axis = .vertical
    return stackView
  }()

  private var cancellables = Set<AnyCancellable>()
  private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
  var valuePublisher: AnyPublisher<Tip, Never> {
    tipSubject.eraseToAnyPublisher()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    observe()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been initialized")
  }

  private func observe() {
    tipSubject.sink { [weak self] tip in
      guard let self else { return }
      resetView()
      switch tip {
      case .none:
        break
      case .tenPercent:
        tenPercentTipButton.backgroundColor = .secondary
      case .fifteenPercent:
        fifteenPercentTipButton.backgroundColor = .secondary
      case .twentyPercent:
        twentyPercentTipButton.backgroundColor = .secondary
      case .custom(let value):
        customTipButton.backgroundColor = .secondary
        let text = NSMutableAttributedString(string: "\(value) BAM",
                                             attributes: [.font: UIFont.custom(type: .bold, size: 20)])
        // swiftlint:disable:next legacy_constructor
        text.addAttributes([.font: UIFont.custom(type: .bold, size: 14)], range: NSMakeRange(text.length - 3, 3))
        customTipButton.setAttributedTitle(text, for: .normal)
      }
    }.store(in: &cancellables)
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
  private func handleCustomTipButton() {
    let alertController: UIAlertController = {
      let controller = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
      controller.addTextField { textField in
        textField.placeholder = "Make it generous!"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
        guard let self else { return }
        guard
          let text = controller.textFields?.first?.text,
          let value = Int(text) else { return }
        tipSubject.send(.custom(value: value))
      }
      [okAction, cancelAction].forEach(controller.addAction(_:))
      return controller
    }()
    parentViewController?.present(alertController, animated: true)
  }

  private func resetView() {
    [tenPercentTipButton,
    fifteenPercentTipButton,
    twentyPercentTipButton,
     customTipButton].forEach {
      $0.backgroundColor = .primary
    }
    let text = NSMutableAttributedString(string: "Custom tip",
                                         attributes: [.font: UIFont.custom(type: .bold, size: 20)])
    customTipButton.setAttributedTitle(text, for: .normal)
  }

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
