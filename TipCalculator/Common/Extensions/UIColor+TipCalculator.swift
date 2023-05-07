//
//  UIColor+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit

extension UIColor {
  // swiftlint:disable:next identifier_name
  static let bg = UIColor(hexString: "f5f3f4")
  static let primary = UIColor(hexString: "1cc9be")
  static let secondary = UIColor.systemOrange
  static let text = UIColor(hexString: "000000")
  static let separator = UIColor(hexString: "cccccc")
}

extension UIColor {
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    // swiftlint:disable:next identifier_name
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}
