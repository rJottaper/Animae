//
//  ANWatctButton.swift
//  Animae
//
//  Created by João Pedro Rocha on 04/12/24.
//

import UIKit

class ANButton: UIButton {
  private var originalAlpha: CGFloat = 1.0;
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureButton();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  init(title: String, iconName: String? = nil) {
    super.init(frame: .zero);
    
    self.setTitle(title, for: .normal);
    
    if iconName != nil && iconName != "" {
      self.setImage(UIImage(systemName: iconName!), for: .normal);
      self.tintColor = .black;
      self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 22), forImageIn: .normal);
      self.imageEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 14);
    };
    
    configureButton();
    self.addTarget(self, action: #selector(applyOpacityEffect), for: .touchUpInside);
  };
  
  private func configureButton() {
    translatesAutoresizingMaskIntoConstraints = false;
    backgroundColor = .white;
    setTitleColor(.black, for: .normal);
    titleLabel?.font =  UIFont.systemFont(ofSize: 20);
    layer.cornerRadius = 8;
  };
  
  @objc private func applyOpacityEffect() {
    originalAlpha = self.alpha
      
    UIView.animate(withDuration: 0.3) {
      self.alpha = 0.5;
    };
      
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      UIView.animate(withDuration: 0.3) {
        self.alpha = self.originalAlpha;
      };
    };
  };
};
