//
//  MyAnimesViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 23/01/25.
//

import UIKit

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
    
    NSLayoutConstraint.activate([
      myAnimesView.topAnchor.constraint(equalTo: view.topAnchor),
      myAnimesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myAnimesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myAnimesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};
