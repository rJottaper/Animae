//
//  UIViewController+Utilities.swift
//  Animae
//
//  Created by João Pedro Rocha on 20/01/25.
//

import UIKit

extension UIViewController {
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large);
    let image = UIImage(systemName: imageName, withConfiguration: configuration);
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0);
  };
}
