//
//  SceneDelegate.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 2/23/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let viewController = CalculatorViewController()
    window.rootViewController = viewController
    self.window = window
    window.makeKeyAndVisible()
  }
}
