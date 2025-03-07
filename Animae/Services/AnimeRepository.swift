//
//  AnimeRepository.swift
//  Animae
//
//  Created by João Pedro Rocha on 04/03/25.
//

import UIKit
import CoreData

class AnimeRepository {
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
  
  func getAnimesSaved() -> [AnimeModel] {
    do {
      let savedAnimes = try self.context.fetch(AnimeModel.fetchRequest());
      return savedAnimes
    } catch {
      print("Failed to get saved animes: \(error.localizedDescription)");
      return [];
    };
  };
  
  func isAnimeSaved(_ anime: Anime) -> Bool {
    do {
      let fetchRequest: NSFetchRequest<AnimeModel> = AnimeModel.fetchRequest();
      fetchRequest.predicate = NSPredicate(format: "id == %d", anime.id);
      
      let savedAnimes = try self.context.fetch(fetchRequest);
      
      return !savedAnimes.isEmpty;
    } catch {
      print("Failed to get animes saved: \(error.localizedDescription)");
      return false
    };
  };
  
  func saveAnime(_ anime: Anime) {
    _ = AnimeModel(from: anime, context: context.self);
    
    do {
      try self.context.save();
      print("\(anime.title) foi adicionado aos favoritos");
    } catch {
      print("Erro ao salvar anime: \(error.localizedDescription)");
    };
  };
  
  func removeAnime(_ anime: Anime) {
    do {
      let fetchRequest: NSFetchRequest<AnimeModel> = AnimeModel.fetchRequest();
      fetchRequest.predicate = NSPredicate(format: "id == %d", anime.id);
      
      let animes = try self.context.fetch(fetchRequest);
      
      if let animeToDelete = animes.first {
        self.context.delete(animeToDelete);
        
        do {
          try self.context.save();
          print("\(anime.title) foi removido dos favoritos");
        } catch {
          print("Erro ao remover anime: \(error.localizedDescription)");
        };
      };
    } catch {
      print("Falha ao tentar remover um anime.")
    };
  };
};
