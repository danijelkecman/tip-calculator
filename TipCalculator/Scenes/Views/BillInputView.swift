//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class BillInputView: UIView {
  let headerView = HeaderView()
  let textFieldContainerView = UIView()
  let currencyLabel = UILabel()
  let billTextField = UITextField()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been initialized")
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
