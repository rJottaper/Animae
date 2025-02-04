//
//  WatchAnimeViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 03/02/25.
//

import UIKit

class WatchAnimeViewController: UIViewController {
  let watchAnimeView = WatchAnimeView();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureWatchAnimeView();
  };
  
  func configureVideo(withId trailerId: String) {
    watchAnimeView.youtubeView.load(withVideoId: trailerId);
  };
  
  private func configureWatchAnimeView() {
    view.addSubview(watchAnimeView);
    
    watchAnimeView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      watchAnimeView.topAnchor.constraint(equalTo: view.topAnchor),
      watchAnimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      watchAnimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      watchAnimeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};
