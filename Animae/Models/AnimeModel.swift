//
//  AnimeModel.swift
//  Animae
//
//  Created by João Pedro Rocha on 07/11/24.
//

import UIKit

struct AnimesResponse : Decodable {
  let data: [Anime];
};

struct Anime: Decodable {
  let id: Int;
  let title: String;
  let episodes: Int;
  let synopsis: String;
  let url: String;
  let imageUrl: String;
  let trailerUrl: String?
  
  private enum CodingKeys: String, CodingKey {
    case id = "mal_id";
    case title;
    case episodes;
    case synopsis;
    case url;
    case images;
    case trailer;
  };
  
  private enum ImagesKeys: String, CodingKey {
    case jpg;
  };
  
  private enum JpgKeys: String, CodingKey {
    case imageUrl = "image_url";
  };
  
  private enum TrailerKeys: String, CodingKey {
    case youtube_id;
  };
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self);
    
    id = try container.decode(Int.self, forKey: .id);
    title = try container.decode(String.self, forKey: .title);
    episodes = try container.decode(Int.self, forKey: .episodes);
    synopsis = try container.decode(String.self, forKey: .synopsis);
    url = try container.decode(String.self, forKey: .url);
    
    let imagesContainer = try container.nestedContainer(keyedBy: ImagesKeys.self, forKey: .images);
    let jpgContainer = try imagesContainer.nestedContainer(keyedBy: JpgKeys.self, forKey: .jpg);
    imageUrl = try jpgContainer.decode(String.self, forKey: .imageUrl);
    
    // Sempre que for Opcional deve ser tratado para funcionar.
    if let trailerContainer = try? container.nestedContainer(keyedBy: TrailerKeys.self, forKey: .trailer) {
      trailerUrl = try? trailerContainer.decode(String.self, forKey: .youtube_id);
    } else {
      trailerUrl = nil;
    };
  };
};

extension Anime {
  init(from animeModel: AnimeModel) {
    self.id = Int(animeModel.id);
    self.title = animeModel.title ?? "Sem título";
    self.episodes = Int(animeModel.episodes);
    self.synopsis = animeModel.synopsis ?? "Sem descrição";
    self.url = animeModel.url ?? "";
    self.imageUrl = animeModel.imageUrl ?? "";
    self.trailerUrl = animeModel.trailerUrl;
  };
};
