//
//  MyAnimesViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 23/01/25.
//

import UIKit
import CoreData

class MyAnimesViewController: UIViewController {
  let myAnimesView = MyAnimesView();
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureHeader();
    configureMyAnimesView();
  };
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    
    getSavedAnimes();
  };
  
  private func getSavedAnimes() {
    do {
      let savedAnimes = try self.context.fetch(AnimeModel.fetchRequest());
      myAnimesView.animes = savedAnimes;
    } catch {
      print("Failed to get saved animes: \(error.localizedDescription)");
    }
  };
};

extension MyAnimesViewController: MyAnimesViewDelegate {
  func getAnimeDetails(anime: Anime) {
    let animeDetailsViewController = AnimeDetailsViewController();
    animeDetailsViewController.configure(with: anime);
    
    SceneDelegate.shared?.pushViewController(viewController: animeDetailsViewController);
  };
  
  func removeSavedAnime(anime: AnimeModel) {
    let animeTitle = anime.title ?? ""
    
    let alert = UIAlertController(title: "Ei Nerd", message: "Tem certeza que deseja remover \(animeTitle) da sua lista?", preferredStyle: .alert);
    alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { [weak self] action in
      guard let self = self else { return }
      
      do {
        let fetchRequest: NSFetchRequest<AnimeModel> = AnimeModel.fetchRequest();
        fetchRequest.predicate = NSPredicate(format: "id == %d", anime.id);
        
        let animes = try self.context.fetch(fetchRequest);
        
        if let animeToRemove = animes.first {
          self.context.delete(animeToRemove);
          
          do {
            try self.context.save();
            print("\(animeTitle) foi removido da lista.")
            self.getSavedAnimes();
          } catch {
            print("Falha ao tentar salvar o core data atualizado. \(error.localizedDescription)");
          }
        };
      } catch {
        print("Falha ao tentar remover um anime. \(error.localizedDescription)");
      };
    }));
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel));
    
    present(alert, animated: true);
  };
};

extension MyAnimesViewController {
  private func configureHeader() {
    navigationItem.title = "Meus Animes";
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let appearance = UINavigationBarAppearance();
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white];
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white];
    appearance.backgroundColor = .black;
    
    navigationItem.standardAppearance = appearance;
    navigationItem.scrollEdgeAppearance = appearance;
  };
  
  private func configureMyAnimesView() {
    view.addSubview(myAnimesView);
    
    myAnimesView.translatesAutoresizingMaskIntoConstraints = false;
    myAnimesView.delegate = self;
    
    NSLayoutConstraint.activate([
      myAnimesView.topAnchor.constraint(equalTo: view.topAnchor),
      myAnimesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myAnimesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myAnimesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};
