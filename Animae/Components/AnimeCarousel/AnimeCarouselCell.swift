//
//  AnimeCarouselCell.swift
//  Animae
//
//  Created by João Pedro Rocha on 30/10/24.
//

import UIKit

class AnimeCarouselCell: UITableViewCell {
  static let identifier: String = "AnimeCarouselCell"
  
  var animes: AnimesResponse?
  
  let animeCell: UICollectionView = {
    let layout = UICollectionViewFlowLayout();
    let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);

    layout.scrollDirection = .horizontal;
    layout.itemSize = CGSize(width: 140, height: 200);
    layout.collectionView?.backgroundColor = .black;

    cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell");
    
    return cardCollectionView;
  }();

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    contentView.addSubview(animeCell);
    
    animeCell.delegate = self;
    animeCell.dataSource = self;
  };
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    animeCell.frame = contentView.bounds;
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  func configure(with animes: AnimesResponse) {
    self.animes = animes;
    animeCell.reloadData();
  };
};

extension AnimeCarouselCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return animes?.data.count ?? 0;
    };
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let animeDetailsViewController = AnimeDetailsViewController(anime: animes?.data[indexPath.row]);
    animeDetailsViewController.configure(with: animes?.data[indexPath.row]);
    
    SceneDelegate.shared?.pushViewController(viewController: animeDetailsViewController);
  };
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
    
    if let anime = animes?.data[indexPath.row] {
      let imageView = UIImageView(frame: cell.bounds);
      imageView.clipsToBounds = true;
      imageView.layer.cornerRadius = 10;
      imageView.downloaded(from: anime.imageUrl);
      
      cell.addSubview(imageView);
    };
    
    return cell
  };
};
