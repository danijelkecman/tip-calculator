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
  private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    view.addGestureRecognizer(tapGesture)
    return tapGesture.tapPublisher.flatMap { _ in
      Just(())
    }.eraseToAnyPublisher()
  }()
  
  private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    tapGesture.numberOfTapsRequired = 2
    contentView.logoView.addGestureRecognizer(tapGesture)
    return tapGesture.tapPublisher.flatMap { _ in
      Just(())
    }.eraseToAnyPublisher()
  }()

  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Private methods
extension CalculatorViewController {
  func setupViews() {
    setupContentView()
  }

  func setupContentView() {
    bindViewModels()
    bindObserver()
  }

  private func bindViewModels() {
    let input = CalculatorViewModel.Input(
      billPublisher: contentView.billInputView.valuePublisher,
      tipPublisher: contentView.tipInputView.valuePublisher,
      splitPublisher: contentView.splitInputView.valuePublisher,
      logoViewTapPublisher: logoViewTapPublisher
    )
    let output = viewModel.transform(input: input)

    output.updateViewPublisher.sink { [unowned self] result in
      contentView.resultView.configure(result: result)
    }
    .store(in: &cancellables)
  }
  
  func bindObserver() {
    viewTapPublisher.sink { [unowned self] in
      view.endEditing(true)
    }.store(in: &cancellables)
    
    logoViewTapPublisher.sink { [unowned self] in
      contentView.billInputView.reset()
      contentView.tipInputView.reset()
      contentView.splitInputView.reset()
      
      UIView.animate(
        withDuration: 0.1,
        delay: 0,
        usingSpringWithDamping: 5.0,
        initialSpringVelocity: 0.5,
        options: .curveEaseInOut) {
          self.contentView.logoView.transform = .init(scaleX: 1.5, y: 1.5)
        } completion: { _ in
          UIView.animate(withDuration: 0.1) {
            self.contentView.logoView.transform = .identity
          }
        }
    }.store(in: &cancellables)
  }
}
