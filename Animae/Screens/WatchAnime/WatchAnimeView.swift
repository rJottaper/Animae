//
//  WatchAnimeView.swift
//  Animae
//
//  Created by João Pedro Rocha on 03/02/25.
//

import UIKit
import youtube_ios_player_helper

class WatchAnimeView: UIView {
  let youtubeView = YTPlayerView();
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureYoutubeView();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  private func configureYoutubeView() {
    addSubview(youtubeView);
    
    youtubeView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      youtubeView.topAnchor.constraint(equalTo: topAnchor),
      youtubeView.leadingAnchor.constraint(equalTo: leadingAnchor),
      youtubeView.trailingAnchor.constraint(equalTo: trailingAnchor),
      youtubeView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
};
