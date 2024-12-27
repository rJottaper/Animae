//
//  HomeViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 17/10/24.
//

import UIKit

class HomeViewController: UIViewController {
  let scrollView = UIScrollView();
  let homeView = HomeView();
  
  let animeService = AnimeService();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    getAnimes();
    configureHeader();
    configureScrollView();
    configureHomeView();
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    configureScrollView();
  };
  
  private func getAnimes() {
    Task {
      do {
        let animes = try await animeService.getTopAnime();
        homeView.configureAnimes(with: animes);
      } catch AnimeServiceError.invalidResponse {
        print("Failed to get animes");
      };
    };
  };
};

extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.contentOffset.y = 0;
    };
    
    if scrollView.contentOffset.y >= 320 {
      navigationItem.rightBarButtonItem = nil;
    };
    
    if scrollView.contentOffset.y < 320 {
      configureHeader();
    };
  };
  
  @objc func tapSearchButton() {
    SceneDelegate.shared?.pushViewController(viewController: SearchAnimeViewController());
  };
}

// MARK: LAYOUT

extension HomeViewController {
  private func configureHeader() {
    let searchButton = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular));
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: searchButton,
      style: .plain,
      target: self,
      action: #selector(tapSearchButton)
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
      scrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
    ]);
  };
  
  private func configureHomeView() {
    scrollView.addSubview(homeView);
    
    homeView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      homeView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      homeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      homeView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      homeView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      homeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
};
