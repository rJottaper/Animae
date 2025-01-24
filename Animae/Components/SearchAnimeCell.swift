//
//  SearchAnimeCell.swift
//  Animae
//
//  Created by João Pedro Rocha on 05/01/25.
//

import UIKit

class SearchAnimeCell: UITableViewCell {
  static let identifier: String = "SearchAnimeCell";
  
  let animeImage = UIImageView();
  let animeTitle = UILabel();
  let animeEpisodes = UILabel();
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    contentView.backgroundColor = .black;
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  func configure(anime: Anime) {
    animeImage.downloaded(from: anime.imageUrl);
    animeTitle.text = anime.title;
    animeEpisodes.text = "\(anime.episodes) \(anime.episodes > 1 ? "Episódios" : "Episódio")"
  };
};

extension SearchAnimeCell {
  private func configureLayout() {
    configureAnimeImage();
    configureAnimeTitle();
    configureAnimeEpisodes();
  };
  
  private func configureAnimeImage() {
    contentView.addSubview(animeImage);
    
    animeImage.translatesAutoresizingMaskIntoConstraints = false;
    animeImage.clipsToBounds = true;
    animeImage.layer.cornerRadius = 10;
    
    NSLayoutConstraint.activate([
      animeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      animeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      animeImage.widthAnchor.constraint(equalToConstant: 160),
      animeImage.heightAnchor.constraint(equalToConstant: 160)
    ]);
  };
  
  private func configureAnimeTitle() {
    contentView.addSubview(animeTitle);
    
    animeTitle.translatesAutoresizingMaskIntoConstraints = false;
    animeTitle.font = .systemFont(ofSize: 18, weight: .bold);
    animeTitle.textColor = .white;
    animeTitle.numberOfLines = 2;
    
    NSLayoutConstraint.activate([
      animeTitle.topAnchor.constraint(equalTo: animeImage.topAnchor),
      animeTitle.leadingAnchor.constraint(equalTo: animeImage.trailingAnchor),
      animeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
    ]);
  };
  
  private func configureAnimeEpisodes() {
    contentView.addSubview(animeEpisodes);
    
    animeEpisodes.translatesAutoresizingMaskIntoConstraints = false;
    animeEpisodes.font = .systemFont(ofSize: 16, weight: .regular);
    animeEpisodes.textColor = .gray;
    
    NSLayoutConstraint.activate([
      animeEpisodes.topAnchor.constraint(equalTo: animeTitle.bottomAnchor, constant: 10),
      animeEpisodes.leadingAnchor.constraint(equalTo: animeImage.trailingAnchor),
      animeEpisodes.trailingAnchor.constraint(equalTo: trailingAnchor),
      animeEpisodes.heightAnchor.constraint(equalToConstant: 20)
    ]);
  };
};
