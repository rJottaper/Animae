//
//  SceneDelegate.swift
//  Animae
//
//  Created by João Pedro Rocha on 17/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  static var shared: SceneDelegate? {
    return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive })?.delegate as? SceneDelegate
  };
  
  var window: UIWindow?
  
  let homeViewController = HomeViewController();

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds);
    window?.windowScene = windowScene;
    window?.makeKeyAndVisible();
    
    setViewController(viewController: homeViewController);
  };
};

extension SceneDelegate {
  private func setViewController(viewController: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = viewController;
      self.window?.makeKeyAndVisible();
      
      return
    };
    
    let navController = UINavigationController(rootViewController: viewController);
    configureNavigationBarAppearance(navigationController: navController);
    
    window.rootViewController = navController;
    window.makeKeyAndVisible();
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil);
  };
  
  func pushViewController(viewController: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = viewController;
      self.window?.makeKeyAndVisible();
      
      return
    };
    
    let navigationController = window.rootViewController as! UINavigationController;
    
    let transition = CATransition();
    transition.duration = 0.5;
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut);
    transition.type = CATransitionType.moveIn;
    transition.subtype = CATransitionSubtype.fromTop;
    
    navigationController.view.layer.add(transition, forKey: nil);
    navigationController.pushViewController(viewController, animated: false);
    
    viewController.navigationController?.navigationBar.backItem?.title = "";
    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "xmark"),
      style: .plain,
      target: self,
      action: #selector(SceneDelegate.shared?.popViewController)
    );
    viewController.navigationController?.navigationBar.tintColor = .white;
  };
  
  @objc func popViewController() {
    guard let window = self.window else {
      self.window?.rootViewController = nil;
      self.window?.makeKeyAndVisible();
      
      return
    };
    
    let navigationController = window.rootViewController as! UINavigationController;
    let transition = CATransition();
    
    transition.duration = 0.5;
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut);
    transition.type = CATransitionType.reveal;
    transition.subtype = CATransitionSubtype.fromBottom;
    
    navigationController.view.layer.add(transition, forKey: nil);
    navigationController.popViewController(animated: false);
  }
  
  func configureNavigationBarAppearance(navigationController: UINavigationController?) {
    let appearance = UINavigationBarAppearance();
    appearance.configureWithOpaqueBackground();
    appearance.backgroundColor = .clear;
    appearance.shadowColor = .clear;
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white];
        
    navigationController?.navigationBar.standardAppearance = appearance;
    navigationController?.navigationBar.scrollEdgeAppearance = appearance;
  };
  
  private func configureTabBar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground();
    appearance.backgroundColor = .gray;
    appearance.shadowColor = .red;
    
    UITabBar.appearance().standardAppearance = appearance;
    UITabBar.appearance().scrollEdgeAppearance = appearance;
    UITabBar.appearance().isTranslucent = false;
    UITabBar.appearance().tintColor = .white;

    let tabBarViewController = UITabBarController();
    tabBarViewController.view.backgroundColor = .black;
  
    homeViewController.setTabBarImage(imageName: "house.fill", title: "Home");
    
    let home = UINavigationController(rootViewController: homeViewController);

    tabBarViewController.setViewControllers([home], animated: true);

    window?.rootViewController = tabBarViewController;
    window?.makeKeyAndVisible();
  }
};

