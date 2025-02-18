//
//  MyProfileView.swift
//  Animae
//
//  Created by João Pedro Rocha on 08/02/25.
//

import UIKit

protocol MyProfileViewDelegate: AnyObject {
  func didTapGetPhoto();
}

class MyProfileView: UIView {
  let profileImageDefault = UIImageView();
  let profileName = UILabel();
  let profileDescription = UILabel();
  let profileLeaveButton = ANButton(title: "Sair", background: .red);
  
  weak var delegate: MyProfileViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension MyProfileView {
  @objc private func getImageFromLib() {
    delegate?.didTapGetPhoto();
  };
};

extension MyProfileView {
  private func configureLayout() {
    configureProfileImageViewDefault();
    configureProfileName();
    configureProfileDescription();
    configureProfileLeaveButton();
  };
  
  private func configureProfileImageViewDefault() {
    addSubview(profileImageDefault);
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getImageFromLib))
    
    profileImageDefault.translatesAutoresizingMaskIntoConstraints = false;
    profileImageDefault.image = UIImage(named: "UserDefault");
    profileImageDefault.clipsToBounds = true;
    profileImageDefault.layer.cornerRadius = 90;
    profileImageDefault.isUserInteractionEnabled = true;
    profileImageDefault.addGestureRecognizer(tapGesture);
    
    NSLayoutConstraint.activate([
      profileImageDefault.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      profileImageDefault.widthAnchor.constraint(equalToConstant: 180),
      profileImageDefault.heightAnchor.constraint(equalToConstant: 180),
      profileImageDefault.centerXAnchor.constraint(equalTo: centerXAnchor)
    ]);
  };
  
  private func configureProfileName() {
    addSubview(profileName);
    
    profileName.translatesAutoresizingMaskIntoConstraints = false;
    profileName.textAlignment = .center;
    profileName.text = "Jotinha";
    profileName.textColor = .white;
    profileName.font = UIFont.systemFont(ofSize: 28, weight: .bold);
    
    NSLayoutConstraint.activate([
      profileName.topAnchor.constraint(equalTo: profileImageDefault.bottomAnchor, constant: 20),
      profileName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      profileName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      profileName.heightAnchor.constraint(equalToConstant: 30)
    ]);
  };
  
  private func configureProfileDescription() {
    addSubview(profileDescription);
    
    profileDescription.translatesAutoresizingMaskIntoConstraints = false;
    profileDescription.textAlignment = .center;
    profileDescription.text = "Você pode atualizar sua foto de perfil sempre que quiser! Basta tocar sobre ela e escolher uma nova imagem para deixar seu perfil ainda mais personalizado.";
    profileDescription.textColor = .gray;
    profileDescription.font = UIFont.systemFont(ofSize: 20, weight: .regular);
    profileDescription.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      profileDescription.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 40),
      profileDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      profileDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
    ]);
  };
  
  private func configureProfileLeaveButton() {
    addSubview(profileLeaveButton);
    
    profileLeaveButton.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      profileLeaveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
      profileLeaveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      profileLeaveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      profileLeaveButton.heightAnchor.constraint(equalToConstant: 60)
    ]);
  };
};
