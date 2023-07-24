//
//  ViewController.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit
import Combine

class CalculatorViewController: UIViewController {

  private lazy var contentView = CalculatorContentView()
  private let viewModel = CalculatorViewModel()
  private var cancellables = Set<AnyCancellable>()

  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    bindViewModels()
  }
}

// MARK: - Private methods
extension CalculatorViewController {
  func setupViews() {
    setupContentView()
  }

  func setupContentView() {

  }

  private func bindViewModels() {
    contentView.billInputView.valuePublisher.sink { bill in
      print("bill \(bill)")
    }.store(in: &cancellables)

    let input = CalculatorViewModel.Input(
      billPublisher: contentView.billInputView.valuePublisher,
      tipPublisher: contentView.tipInputView.valuePublisher,
      splitPublisher: Just(5).eraseToAnyPublisher()
    )
    let output = viewModel.transform(input: input)
    output.updateViewPublisher.sink { result in
      print(">>>> \(result)")
    }.store(in: &cancellables)
  }
}
