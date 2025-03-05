//
//  AnimeDetailsViewModel.swift
//  Animae
//
//  Created by João Pedro Rocha on 04/03/25.
//

import UIKit

class AnimeDetailsViewModel {
  private let animeRepository = AnimeRepository();
  private var anime: Anime?
  
  var isSaved: Bool = false {
    didSet {
      onUpdate?();
    }
  };
  
  var onUpdate: (() -> Void)?
  var onError: ((String) -> Void)?
  
  init(anime: Anime?) {
    self.anime = anime;
  };
  
  func checkIfAnimeIsSaved() {
    guard let anime = anime else { return }
    
    isSaved = animeRepository.isAnimeSaved(anime);
  };
  
  func toggleFavorite() {
    guard let anime = anime else { return }
    
    if (isSaved) {
      animeRepository.removeAnime(anime);
      isSaved = false;
    } else {
      animeRepository.saveAnime(anime);
      isSaved = true;
    };
  };
};
