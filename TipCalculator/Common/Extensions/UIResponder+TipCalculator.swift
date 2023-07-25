//
//  UIResponder+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 7/24/23.
//

import UIKit

extension UIResponder {
  var parentViewController: UIViewController? {
    return next as? UIViewController ?? next?.parentViewController
  }
}
