//
//  SearchAnimeViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 07/12/24.
//

import UIKit

class SearchAnimeViewController: UIViewController {
  let searchAnime = UISearchController();
  
  var animes: AnimesResponse?
  var filteredAnimes: [Anime]?
  
  let animeService = AnimeService();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    navigationItem.leftBarButtonItem = nil;
    navigationItem.setHidesBackButton(true, animated: true);
    
    getAnimes();
    configureAnimeSearch();
  };
  
  private func getAnimes() {
    Task {
      do {
        let animes = try await animeService.getSearchAnimes();
        self.animes = animes;
      } catch AnimeServiceError.invalidResponse {
        print("Failed to get search animes");
      };
    };
  };
  
  private func configureAnimeSearch() {
    searchAnime.searchBar.translatesAutoresizingMaskIntoConstraints = false;
    searchAnime.searchResultsUpdater = self;
    searchAnime.searchBar.delegate = self;
    searchAnime.searchBar.placeholder = "Attack on Titan";
    searchAnime.searchBar.showsCancelButton = true;

    if let searchBarTextField = searchAnime.searchBar.value(forKey: "searchField") as? UITextField {
      searchBarTextField.leftView?.tintColor = .white;
    };
    
    if let textField = searchAnime.searchBar.value(forKey: "searchField") as? UITextField {
      textField.attributedPlaceholder = NSAttributedString(string: "Attack on Titan", attributes: [.foregroundColor: UIColor.gray]);
    };
    
    navigationItem.searchController = searchAnime;
    searchAnime.searchBar.searchTextField.textColor = .white;
  };
};

extension SearchAnimeViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    
  };
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    SceneDelegate.shared?.popViewController();
  };
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredAnimes?.removeAll();
    } else {
      filteredAnimes = animes?.data.filter({
        anime in anime.title.lowercased().contains(searchText.lowercased());
      });
    };
    
    print(filteredAnimes);
  };
};
