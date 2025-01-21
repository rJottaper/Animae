//
//  AnimeModel+CoreDataProperties.swift
//  Animae
//
//  Created by João Pedro Rocha on 20/01/25.
//
//

import Foundation
import CoreData


extension AnimeModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimeModel> {
      return NSFetchRequest<AnimeModel>(entityName: "AnimeModel");
    };

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var episodes: Int64
    @NSManaged public var synopsis: String?
    @NSManaged public var url: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var trailerUrl: String?

};

extension AnimeModel : Identifiable {
  convenience init(from anime: Anime, context: NSManagedObjectContext) {
    self.init(context: context);
    self.id = Int64(anime.id);
    self.title = anime.title;
    self.episodes = Int64(anime.episodes);
    self.synopsis = anime.synopsis;
    self.url = anime.url;
    self.imageUrl = anime.imageUrl;
    self.trailerUrl = anime.trailerUrl;
  };
};
