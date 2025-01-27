//
//  MyAnimesView.swift
//  Animae
//
//  Created by João Pedro Rocha on 23/01/25.
//

import UIKit

protocol MyAnimesViewDelegate: AnyObject {
  func getAnimeDetails(anime: Anime);
  func removeSavedAnime(anime: AnimeModel);
};

class MyAnimesView: UIView {
  let myAnimesTitle = UILabel();
  let myAnimesTableView = UITableView();
  
  var animes: [AnimeModel]? {
    didSet {
      DispatchQueue.main.async {
        self.myAnimesTableView.reloadData();
      };
    }
  };
  
  weak var delegate: MyAnimesViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureMyAnimesTableView();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

extension MyAnimesView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return animes?.count ?? 0;
  };
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchAnimeCell.identifier, for: indexPath) as! SearchAnimeCell;
    
    if let anime = animes?[indexPath.row] {
      let animeFormatted = Anime(from: anime);
      
      cell.configure(anime: animeFormatted);
    };
    
    return cell;
  };
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180;
  };
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let animeModel = animes?[indexPath.row] {
      let anime = Anime(from: animeModel);
      
      delegate?.getAnimeDetails(anime: anime);
    };
  };
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delectionAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
      if let anime = self.animes?[indexPath.row] {
        self.delegate?.removeSavedAnime(anime: anime);
      };
    };
    
    delectionAction.image = UIImage(systemName: "trash");
    delectionAction.backgroundColor = .red;
    
    return UISwipeActionsConfiguration(actions: [delectionAction]);
  };
};

extension MyAnimesView {
  private func configureMyAnimesTableView() {
    addSubview(myAnimesTableView);
    
    myAnimesTableView.translatesAutoresizingMaskIntoConstraints = false;
    myAnimesTableView.backgroundColor = .black;
    myAnimesTableView.separatorStyle = .none;
    myAnimesTableView.register(SearchAnimeCell.self, forCellReuseIdentifier: SearchAnimeCell.identifier);
    myAnimesTableView.delegate = self;
    myAnimesTableView.dataSource = self;
    
    NSLayoutConstraint.activate([
      myAnimesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
      myAnimesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      myAnimesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      myAnimesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
}
