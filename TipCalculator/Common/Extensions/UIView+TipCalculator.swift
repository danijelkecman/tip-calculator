//
//  UIView+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/25/23.
//

import UIKit

extension UIView {
  func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
    layer.cornerRadius = radius
    layer.masksToBounds = false
    layer.shadowOffset = offset
    layer.shadowColor = color.cgColor
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity

    let bgCGColor = backgroundColor?.cgColor
    backgroundColor = nil
    layer.backgroundColor = bgCGColor
  }

  func addCornerRadius(radius: CGFloat) {
    layer.masksToBounds = false
    layer.cornerRadius = radius
  }

  func addRoundCorners(corners: CACornerMask, radius: CGFloat) {
    layer.cornerRadius = radius
    layer.maskedCorners = [corners]
  }
}
