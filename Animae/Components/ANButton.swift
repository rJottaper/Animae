//
//  ANWatctButton.swift
//  Animae
//
//  Created by João Pedro Rocha on 04/12/24.
//

import UIKit

class ANWatctButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureButton();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  init(title: String, iconName: String?) {
    super.init(frame: .zero);
    
    self.setTitle(title, for: .normal);
    
    if iconName != nil {
      self.setImage(UIImage(systemName: iconName!), for: .normal);
    };
  };
  
  private func configureButton() {
    translatesAutoresizingMaskIntoConstraints = false;
    backgroundColor = .white;
    titleLabel?.textColor = .black;
    titleLabel?.font =  UIFont.systemFont(ofSize: 20);
    layer.cornerRadius = 10;
  };
};
