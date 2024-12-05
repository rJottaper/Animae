//
//  AnimeCarousel.swift
//  Animae
//
//  Created by João Pedro Rocha on 30/10/24.
//

import UIKit

class AnimeCarousel: UIView {
  let carouselTitle = UILabel();
  let carouselTableView = UITableView();
  
  var carouselAnimes: AnimesResponse? {
    didSet {
      DispatchQueue.main.async {
        self.carouselTableView.reloadData();
      };
    }
  };
  
  required init(carouselTitle: String) {
    super.init(frame: .zero);
    
    self.carouselTitle.text = carouselTitle;
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension AnimeCarousel: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  };
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AnimeCarouselCell.identifier, for: indexPath) as! AnimeCarouselCell;
    
    if let animes = carouselAnimes {
      cell.configure(with: animes);
    };
    
    return cell
  };
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200;
  };
}

extension AnimeCarousel {
  private func configureLayout() {
    configureCarouselTitle();
    configureCarouselTableView();
  };
  
  private func configureCarouselTitle() {
    addSubview(carouselTitle);
    
    carouselTitle.translatesAutoresizingMaskIntoConstraints = false;
    carouselTitle.font = .systemFont(ofSize: 28);
    carouselTitle.textColor = .white;
    
    NSLayoutConstraint.activate([
      carouselTitle.topAnchor.constraint(equalTo: topAnchor),
      carouselTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      carouselTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
    ]);
  };
  
  private func configureCarouselTableView() {
    carouselTableView.frame = bounds;
    addSubview(carouselTableView);
    
    carouselTableView.translatesAutoresizingMaskIntoConstraints = false;
    carouselTableView.isScrollEnabled = true;
    carouselTableView.delegate = self;
    carouselTableView.dataSource = self;
    carouselTableView.register(AnimeCarouselCell.self, forCellReuseIdentifier: AnimeCarouselCell.identifier);
    
    NSLayoutConstraint.activate([
      carouselTableView.topAnchor.constraint(equalTo: carouselTitle.bottomAnchor, constant: 15),
      carouselTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      carouselTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      carouselTableView.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
};
