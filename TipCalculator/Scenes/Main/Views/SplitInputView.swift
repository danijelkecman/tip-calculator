//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
  private var cancellables = Set<AnyCancellable>()

  private let headerView: HeaderView = {
    let view = HeaderView()
    view.configure(topText: "Split", bottomText: "the total")
    return view
  }()
  private lazy var decrementButton: UIButton = {
    let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
    button.tapPublisher.flatMap { [unowned self] _ in
      return Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
    }.assign(to: \.value, on: splitSubject)
      .store(in: &cancellables)
    return button
  }()
  private lazy var incrementButton: UIButton = {
    let button = buildButton(text: "-", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    button.tapPublisher.flatMap { [unowned self] _ in
      return Just(splitSubject.value + 1)
    }.assign(to: \.value, on: splitSubject)
      .store(in: &cancellables)
    return button
  }()
  private lazy var quantityLabel: UILabel = {
    let label = UILabel()
    label.text = "1"
    label.textAlignment = .center
    label.backgroundColor = .white
    label.font = UIFont.custom(type: .bold, size: 20)
    return label
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      decrementButton,
      quantityLabel,
      incrementButton
    ])
    stackView.axis = .horizontal
    stackView.spacing = 0
    return stackView
  }()

  private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
  var valuePublisher: AnyPublisher<Int, Never> {
    return splitSubject.removeDuplicates().eraseToAnyPublisher()
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
    splitSubject.sink { [unowned self] quantity in
      quantityLabel.text = quantity.stringValue
    }.store(in: &cancellables)
  }
}

extension SplitInputView {
  func setupViews() {
    setupStackView()
    setupHeaderView()
  }

  func setupStackView() {
    addSubview(stackView)

    stackView.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
    }

    [incrementButton, decrementButton].forEach { button in
      button.snp.makeConstraints {
        $0.width.equalTo(button.snp.height)
      }
    }
  }

  func setupHeaderView() {
    addSubview(headerView)

    headerView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalTo(stackView.snp.centerY)
      $0.trailing.equalTo(stackView.snp.leading).offset(-24)
      $0.width.equalTo(68)
    }
  }
}

extension SplitInputView {
  func buildButton(text: String, corners: CACornerMask) -> UIButton {
    let button = UIButton()
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.custom(type: .bold, size: 20)
    button.backgroundColor = .primary
    button.addRoundCorners(corners: corners, radius: 8.0)
    return button
  }
}
