//
//  MyAnimesViewModel.swift
//  Animae
//
//  Created by João Pedro Rocha on 05/03/25.
//

import UIKit

class MyAnimesViewModel {
  private let animeRepository = AnimeRepository();
  
  var onUpdate: (() -> Void)?
  var onError: ((String) -> Void)?
  
  func getAnimes() -> [AnimeModel] {
    return animeRepository.getAnimesSaved();
  };
  
  func removeAnime(_ anime: Anime) {
    animeRepository.removeAnime(anime);
    onUpdate?()
  };
};
