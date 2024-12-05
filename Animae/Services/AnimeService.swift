//
//  AnimeService.swift
//  Animae
//
//  Created by João Pedro Rocha on 12/11/24.
//

import UIKit

enum AnimaServiceError: Error {
  case invalidResponse;
  case invalidData;
};

class AnimeService {
  func getTopAnime() async throws -> AnimesResponse {
    let baseUrl = URL(string: "https://api.jikan.moe/v4/top/anime")!;
    
    let (data, response) = try await URLSession.shared.data(from: baseUrl);
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw AnimaServiceError.invalidResponse;
    };
    
    do {
      let decoder = JSONDecoder();
      return try decoder.decode(AnimesResponse.self, from: data);
    } catch {
      throw AnimaServiceError.invalidData;
    };
  };
};
