//
//  MyProfileViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 08/02/25.
//

import UIKit
import Photos

class MyProfileViewController: UIViewController {
  let myProfileView = MyProfileView();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureMyProfileView();
  };
  
  private func configureMyProfileView() {
    view.addSubview(myProfileView);
    
    myProfileView.translatesAutoresizingMaskIntoConstraints = false;
    myProfileView.delegate = self;
    
    NSLayoutConstraint.activate([
      myProfileView.topAnchor.constraint(equalTo: view.topAnchor),
      myProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};

extension MyProfileViewController: MyProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  private func openGallery() {
    let imagePickerViewController = UIImagePickerController();
    imagePickerViewController.sourceType = .photoLibrary;
    imagePickerViewController.allowsEditing = true;
    imagePickerViewController.delegate = self;
    present(imagePickerViewController, animated: true);
  };
  
  private func openConfig() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    };
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl)
    };
  };
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.editedImage] as? UIImage {
      myProfileView.profileImageDefault.image = image;
    };
    
    picker.dismiss(animated: true);
  };
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true);
  };
  
  func didTapGetPhoto() {
    let status = PHPhotoLibrary.authorizationStatus()
        
    switch status {
    case .authorized, .limited:
      DispatchQueue.main.async {
        self.openGallery();
      };
    case .denied, .restricted:
      DispatchQueue.main.async {
        self.openConfig();
      };
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization { newStatus in
        if newStatus == .authorized || newStatus == .limited {
          DispatchQueue.main.async {
            self.openGallery();
          };
        } else {
          print("Usuário negou a permissão.")
        };
      };
    default:
      print("Estado de autorização desconhecido.")
    };
  };
};
