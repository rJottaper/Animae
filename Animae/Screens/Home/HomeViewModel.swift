//
//  HomeViewModel.swift
//  Animae
//
//  Created by João Pedro Rocha on 24/02/25.
//

import UIKit

class HomeViewModel {
  private let animeService = AnimeService();
  
  var animes: AnimesResponse? {
    didSet {
      onAnimesUpdated?();
    }
  };
  
  var onAnimesUpdated: (() -> Void)?
  var onError: ((String) -> Void)?
  
  func fetchAnimes() {
    Task {
      do {
        let fetchedAnimes = try await animeService.getTopAnime();
        self.animes = fetchedAnimes;
      } catch {
        onError?(error.localizedDescription);
      };
    };
  };
};
