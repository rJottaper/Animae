//
//  SearchAnimeView.swift
//  Animae
//
//  Created by João Pedro Rocha on 20/12/24.
//

import UIKit

class SearchAnimeView: UIView {
  let searchAnimeTableView = UITableView();
  let loading = UIActivityIndicatorView(style: .large);
  
  var animes: [Anime]? {
    didSet {
      DispatchQueue.main.async {
        self.searchAnimeTableView.reloadData();
      };
    }
  };
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureTableView();
    configureLoading();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension SearchAnimeView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return animes?.count ?? 0;
  };
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchAnimeCell.identifier, for: indexPath) as! SearchAnimeCell;
    
    if let anime = animes?[indexPath.row] {
      cell.configure(anime: anime);
    };
    
    return cell
  };
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180
  };
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let animeDetailsViewController = AnimeDetailsViewController(anime: animes?[indexPath.row]);
    animeDetailsViewController.configure(with: animes?[indexPath.row]);
    
    SceneDelegate.shared?.pushViewController(viewController: animeDetailsViewController);
  };
  
  func startLoading() {
    DispatchQueue.main.async {
      self.loading.startAnimating();
      self.loading.isHidden = false;
    }
  };
    
  func stopLoading() {
    DispatchQueue.main.async {
      self.loading.stopAnimating();
      self.loading.isHidden = true;
    }
  };
}

extension SearchAnimeView {
  private func configureTableView() {
    addSubview(searchAnimeTableView);
    
    searchAnimeTableView.translatesAutoresizingMaskIntoConstraints = false;
    searchAnimeTableView.backgroundColor = .black;
    searchAnimeTableView.separatorStyle = .none;
    searchAnimeTableView.register(SearchAnimeCell.self, forCellReuseIdentifier: SearchAnimeCell.identifier);
    searchAnimeTableView.delegate = self;
    searchAnimeTableView.dataSource = self;
    
    NSLayoutConstraint.activate([
      searchAnimeTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
      searchAnimeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchAnimeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      searchAnimeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
  
  private func configureLoading() {
    addSubview(loading);
    
    loading.translatesAutoresizingMaskIntoConstraints = false;
    loading.color = .white;
        
    NSLayoutConstraint.activate([
      loading.topAnchor.constraint(equalTo: topAnchor),
      loading.leadingAnchor.constraint(equalTo: leadingAnchor),
      loading.trailingAnchor.constraint(equalTo: trailingAnchor),
      loading.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  }
};
