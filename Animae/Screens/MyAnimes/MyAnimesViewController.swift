//
//  MyAnimesViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 23/01/25.
//

import UIKit

class MyAnimesViewController: UIViewController {
  let myAnimesView = MyAnimesView();
  let myAnimesViewModel = MyAnimesViewModel();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureHeader();
    configureMyAnimesView();
    
    myAnimesViewModel.onUpdate = { [weak self] in
      self?.getSavedAnimes();
    };
    
    myAnimesViewModel.onError = { errorMessage in
      print("Erro ao buscar os animes: \(errorMessage)");
    };
  };
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    
    getSavedAnimes();
  };
  
  private func getSavedAnimes() {
    let savedAnimes = myAnimesViewModel.getAnimes();
    myAnimesView.animes = savedAnimes;
  };
};

extension MyAnimesViewController: MyAnimesViewDelegate {
  func getAnimeDetails(anime: Anime) {
    let animeDetailsViewController = AnimeDetailsViewController(anime: anime);
    animeDetailsViewController.configure(with: anime);
    
    SceneDelegate.shared?.pushViewController(viewController: animeDetailsViewController);
  };
  
  func removeSavedAnime(anime: Anime) {
    let animeTitle = anime.title ?? ""
    
    let alert = UIAlertController(title: "Ei Nerd", message: "Tem certeza que deseja remover \(animeTitle) da sua lista?", preferredStyle: .alert);
    alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { [weak self] action in
      guard let self = self else { return }
      
      myAnimesViewModel.removeAnime(anime);
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
