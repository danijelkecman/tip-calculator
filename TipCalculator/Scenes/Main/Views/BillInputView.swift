//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BillInputView: UIView {
  let headerView = HeaderView()
  let textFieldContainerView = UIView()
  let currencyLabel = UILabel()
  let billTextField = UITextField()

  private let billSubject: PassthroughSubject<Double, Never> = .init()
  var valuePublisher: AnyPublisher<Double, Never> {
    return billSubject.eraseToAnyPublisher()
  }

  private var cancellables = Set<AnyCancellable>()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    observe()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been initialized")
  }

  private func observe() {
    billTextField.textPublisher.sink { [weak self] text in
      guard let self else { return }
      billSubject.send(text?.doubleValue ?? 0)
    }.store(in: &cancellables)
  }
}

extension BillInputView {
  func setupViews() {
    setupHeaderView()
    setupCurrencyLabel()
    setupBillTextField()
  }

  func setupHeaderView() {
    [headerView, textFieldContainerView].forEach(addSubview(_:))

    headerView.configure(topText: "Enter", bottomText: "your bill")
    headerView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalTo(textFieldContainerView.snp.centerY)
      $0.width.equalTo(68)
      $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
    }

    textFieldContainerView.backgroundColor = .white
    textFieldContainerView.addCornerRadius(radius: 8.0)
    textFieldContainerView.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
    }
  }

  func setupCurrencyLabel() {
    textFieldContainerView.addSubview(currencyLabel)

    currencyLabel.text = "$"
    currencyLabel.font = UIFont.custom(type: .bold, size: 24)
    currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

    currencyLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
    }
  }

  func setupBillTextField() {
    textFieldContainerView.addSubview(billTextField)

    billTextField.borderStyle = .none
    billTextField.font = UIFont.custom(type: .demibold, size: 28)
    billTextField.keyboardType = .decimalPad
    billTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    billTextField.tintColor = .text
    billTextField.textColor = .text

    billTextField.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(currencyLabel.snp.trailing).offset(16)
      $0.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
    }

    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
    toolbar.barStyle = .default
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
    toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
    toolbar.isUserInteractionEnabled = true
    billTextField.inputAccessoryView = toolbar
  }

  @objc
  func doneButtonTapped() {
    billTextField.endEditing(true)
  }
}
