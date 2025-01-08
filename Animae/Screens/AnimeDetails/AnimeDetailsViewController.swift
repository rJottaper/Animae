//
//  AnimeDetailsViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 18/11/24.
//

import UIKit

class AnimeDetailsViewController: UIViewController {
  let scrollView = UIScrollView();
  let animeDetailsView = AnimeDetailsView();
  
  var animeTitle: String = "";
  var isSaved: Bool = false {
    didSet {
      configureHeader();
    }
  };
   
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureHeader();
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3);
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
    
    configureScrollView();
    configureAnimeDetailsView();
    
    animeDetailsView.delegate = self;
  };
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = .clear;
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    scrollView.contentInset = UIEdgeInsets(top: -view.safeAreaInsets.top, left: 0, bottom: 0, right: 0);
  };
  
  func configure(with anime: Anime?) {
    if let animeImage = anime?.imageUrl, let animeTitle = anime?.title, let animeDescription = anime?.synopsis {
      animeDetailsView.animeBanner.downloaded(from: animeImage);
      animeDetailsView.animeTitle.text = animeTitle;
      animeDetailsView.animeDescription.text = animeDescription;
      self.animeTitle = animeTitle;
    };
  };
  
  @objc private func isFavorite() {
    isSaved.toggle();
  };
};

extension AnimeDetailsViewController: UIScrollViewDelegate, AnimeDetailsViewDelegate {
  // ScrollView
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -100 {
      SceneDelegate.shared?.popViewController();
    };
    
    if scrollView.contentOffset.y > 650 {
      navigationItem.title = animeTitle;
    };
    
    if scrollView.contentOffset.y < 650 {
      navigationItem.title = ""
    };
  };
  
  // WatchButton
  func tapWatchButton() {
    print("Assistir \(animeTitle)");
  };
};

// MARK: Layout
extension AnimeDetailsViewController {
  private func configureHeader() {
    let saveButton = UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular));
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: saveButton,
      style: .plain,
      target: self,
      action: #selector(isFavorite)
    );
    navigationItem.rightBarButtonItem?.tintColor = .white;
  };
  
  private func configureScrollView() {
    view.addSubview(scrollView);
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.delegate = self;
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
    ]);
  };
  
  private func configureAnimeDetailsView() {
    scrollView.addSubview(animeDetailsView);
    
    animeDetailsView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      animeDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      animeDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      animeDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      animeDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      animeDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
}
