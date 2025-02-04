//
//  AnimeDetailsViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 18/11/24.
//

import UIKit
import CoreData
import youtube_ios_player_helper

class AnimeDetailsViewController: UIViewController {
  let scrollView = UIScrollView();
  let animeDetailsView = AnimeDetailsView();
  
  var anime: Anime?;
  
  var isSaved: Bool = false {
    didSet {
      configureHeader();
    }
  };
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
   
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureHeader();
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3);
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
    
    configureScrollView();
    configureAnimeDetailsView();
    
    animeDetailsView.delegate = self;
  };
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    
    getSavedAnimes();
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = .clear;
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    scrollView.contentInset = UIEdgeInsets(top: -view.safeAreaInsets.top, left: 0, bottom: 0, right: 0);
  };
  
  func configure(with anime: Anime?) {
    if let animeImage = anime?.imageUrl, let animeTitle = anime?.title, let animeDescription = anime?.synopsis {
      animeDetailsView.animeBanner.downloaded(from: animeImage);
      animeDetailsView.animeTitle.text = animeTitle;
      animeDetailsView.animeDescription.text = animeDescription;
      self.anime = anime;
    };
  };
  
  private func getSavedAnimes() {
    guard let anime = anime else {
      return
    };
    
    do {
      let fetchRequest: NSFetchRequest<AnimeModel> = AnimeModel.fetchRequest();
      fetchRequest.predicate = NSPredicate(format: "id == %d", anime.id);
      
      let savedAnimes = try self.context.fetch(fetchRequest);
      
      if (!savedAnimes.isEmpty) {
        isSaved = true;
      };
    } catch {
      print("Failed to get animes saved: \(error.localizedDescription)");
    };
  }
  
  @objc private func isFavorite() {
    guard let anime = anime else {
      return
    };
    
    if (isSaved) {
      let alert = UIAlertController(title: "Ei Nerd", message: "Deseja remover \(anime.title) da sua lista de favoritos?", preferredStyle: .alert);
      alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { [weak self] action in
        guard let self = self else { return }
        
        do {
          let fetchRequest: NSFetchRequest<AnimeModel> = AnimeModel.fetchRequest();
          fetchRequest.predicate = NSPredicate(format: "id == %d", anime.id);
          
          let animes = try self.context.fetch(fetchRequest);
          
          if let animeToDelete = animes.first {
            self.context.delete(animeToDelete);
            
            do {
              try self.context.save();
              print("\(anime.title) foi removido dos favoritos");
              isSaved = false;
            } catch {
              print("Erro ao remover anime: \(error.localizedDescription)");
            };
          };
        } catch {
          print("Falha ao tentar remover um anime.")
        }
      }));
      alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel));
      
      present(alert, animated: true);
    } else {
      _ = AnimeModel(from: anime, context: context.self);
      
      do {
        try self.context.save();
        print("\(anime.title) foi adicionado aos favoritos");
        isSaved = true;
      } catch {
        print("Erro ao salvar anime: \(error.localizedDescription)");
      };
    };
  };
};

extension AnimeDetailsViewController: UIScrollViewDelegate, AnimeDetailsViewDelegate {
  // ScrollView
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -100 {
      SceneDelegate.shared?.popViewController();
    };
    
    if scrollView.contentOffset.y > 650 {
      navigationItem.title = anime?.title;
    };
    
    if scrollView.contentOffset.y < 650 {
      navigationItem.title = ""
    };
  };
  
  // WatchButton
  func tapWatchButton() {
    let watchAnimeViewController = WatchAnimeViewController();
    guard let trailerId = anime?.trailerUrl else {
      return watchAnimeViewController.configureVideo(withId: "");
    };
    
    watchAnimeViewController.configureVideo(withId: trailerId);
    
    present(watchAnimeViewController, animated: true);
  };
};

// MARK: Layout
extension AnimeDetailsViewController {
  private func configureHeader() {
    let saveButton = UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular));
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: saveButton,
      style: .plain,
      target: self,
      action: #selector(isFavorite)
    );
    navigationItem.rightBarButtonItem?.tintColor = .white;
  };
  
  private func configureScrollView() {
    view.addSubview(scrollView);
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.delegate = self;
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
    ]);
  };
  
  private func configureAnimeDetailsView() {
    scrollView.addSubview(animeDetailsView);
    
    animeDetailsView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      animeDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      animeDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      animeDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      animeDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      animeDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
}
