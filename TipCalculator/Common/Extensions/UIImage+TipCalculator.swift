//
//  UIImage+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit

enum XCAssetImage: String {
  case logo = "icCalculatorBW"
}

extension UIImage {
  convenience init(_ xcAsset: XCAssetImage) {
    // swiftlint:disable:next force_unwrapping
    self.init(named: xcAsset.rawValue)!
  }
}
