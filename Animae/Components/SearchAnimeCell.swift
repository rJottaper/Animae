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
  };
};

extension SearchAnimeCell {
  private func configureLayout() {
    configureAnimeImage();
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
};
