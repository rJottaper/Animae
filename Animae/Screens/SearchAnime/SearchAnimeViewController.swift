//
//  SearchAnimeViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 07/12/24.
//

import UIKit

class SearchAnimeViewController: UIViewController {
  let searchAnime = UISearchController();
  let searchAnimeView = SearchAnimeView();
  let searchAnimeViewModel = SearchAnimeViewModel();
  
  var animes: AnimesResponse?
  var filteredAnimes: [Anime]?
  var debounceWorkItem: DispatchWorkItem?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    navigationItem.leftBarButtonItem = nil;
    navigationItem.setHidesBackButton(true, animated: true);
    
    setupBindings()
    searchAnimeViewModel.getAnimes();
    
    configureAnimeSearch();
    configureSearchAnimeView();
  };
  
  private func setupBindings() {
    searchAnimeViewModel.onUpdate = { [weak self] in
      guard let animes = self?.searchAnimeViewModel.animes else { return }
      
      self?.animes = animes;
    };
    
    searchAnimeViewModel.onError = { errorMessage in
      print("Erro ao buscar os animes: \(errorMessage)");
    };
  };
};

extension SearchAnimeViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    
  };
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    SceneDelegate.shared?.popViewController();
  };
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchAnimeView.startLoading();
    debounceWorkItem?.cancel();
    
    let workItem = DispatchWorkItem { [weak self] in
      guard let self else { return }
      
      if searchText.isEmpty {
        filteredAnimes = [];
      } else {
        filteredAnimes = animes?.data.filter({
          anime in anime.title.lowercased().contains(searchText.lowercased());
        });
      };
      
      self.searchAnimeView.animes = filteredAnimes;
    };
    
    debounceWorkItem = workItem;
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem);
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: searchAnimeView.stopLoading);
  };
};

extension SearchAnimeViewController {
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
  
  private func configureSearchAnimeView() {
    view.addSubview(searchAnimeView);
    
    searchAnimeView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      searchAnimeView.topAnchor.constraint(equalTo: view.topAnchor),
      searchAnimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchAnimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchAnimeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};
