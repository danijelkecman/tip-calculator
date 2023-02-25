//
//  UIFont+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit

extension UIFont {
  static func custom(type: FontStyle, size: CGFloat) -> UIFont {
    UIFont(name: type.name, size: size) ?? .systemFont(ofSize: size)
  }
}

public enum FontStyle: String {
  case regular = "Regular"
  case demibold = "Demi Bold"
  case bold = "Bold"
}

extension FontStyle {
  static let fontFamilyName = "Avenir Next"
  
  var name: String {
    switch self {
    case .regular:
      return FontStyle.fontFamilyName
    case .bold, .demibold:
      return "\(FontStyle.fontFamilyName) \(rawValue)"
    }
  }
}
