//
//  SceneDelegate.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var coordinator: MainCoordinator?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)

    let navVC = UINavigationController()
    coordinator = MainCoordinator(navigationController: navVC)

    window?.rootViewController = navVC
    window?.makeKeyAndVisible()

    coordinator?.start()
  }
}
