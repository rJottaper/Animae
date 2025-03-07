//
//  SearchAnimeViewModel.swift
//  Animae
//
//  Created by João Pedro Rocha on 06/03/25.
//

import UIKit

class SearchAnimeViewModel {
  private let animeService = AnimeService();
  
  var animes: AnimesResponse? {
    didSet {
      onUpdate?();
    }
  };
  
  var onUpdate: (() -> Void)?
  var onError: ((String) -> Void)?
  
  func getAnimes() {
    Task {
      do {
        let animes = try await animeService.getTopAnime();
        self.animes = animes;
      } catch {
        onError?(error.localizedDescription);
      };
    };
  };
};
