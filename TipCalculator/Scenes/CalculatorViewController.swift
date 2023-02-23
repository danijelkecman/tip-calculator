//
//  ViewController.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
  
  private lazy var contentView = CalculatorContentView()

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
    
  }
}

