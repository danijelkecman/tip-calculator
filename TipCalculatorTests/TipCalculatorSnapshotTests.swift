//
//  TipCalculatorSnapshotTests.swift
//  TipCalculatorTests
//
//  Created by Danijel Kecman on 8/13/23.
//

import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTests: XCTestCase {
  private var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
  }
  
  func testLogoView() {
    // given
    let size = CGSize(width: screenWidth, height: 48)
    // when
    let view = LogoView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialResultsView() {
    // given
    let size = CGSize(width: screenWidth, height: 224)
    // when
    let view = ResultView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testResultsViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 224)
    // when
    let view = ResultView()
    let result = CalculatorResult(amountPerson: 100.0, totalBill: 110, totalTip: 10)
    view.configure(result: result)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialTipInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56+56+16)
    // when
    let view = TipInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialTipInputViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 56+56+16)
    // when
    let view = TipInputView()
    guard let button = view.allSubViewsOf(type: UIButton.self).first else { return }
    button.sendActions(for: .touchUpInside)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testBillInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = BillInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testBillInputViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = BillInputView()
    guard let textField = view.allSubViewsOf(type: UITextField.self).first else { return }
    textField.text = "500"
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testSplitInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = SplitInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testSplitInputViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 56+56+16)
    // when
    let view = SplitInputView()
    guard let button = view.allSubViewsOf(type: UIButton.self).first else { return }
    button.sendActions(for: .touchUpInside)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
}

extension UIView {
  func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
    var all = [T]()
    func getSubView(view: UIView) {
      if let aView = view as? T {
        all.append(aView)
      }
      guard !view.subviews.isEmpty else { return }
      view.subviews.forEach { getSubView(view: $0) }
    }
    getSubView(view: self)
    return all
  }
}
