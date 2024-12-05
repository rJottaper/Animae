//
//  HomeView.swift
//  Animae
//
//  Created by João Pedro Rocha on 17/10/24.
//

import UIKit

class HomeView: UIView {
  let highlightAnime = UIImageView();
  let highlightPlayButton = UIButton();
  let isAvailableText = UILabel();
  let highlightAnimeTitle = UILabel();
  let loading = UIActivityIndicatorView(style: .large);
  
  let popularCarousel = AnimeCarousel(carouselTitle: "Popular");
  let romanceCarousel = AnimeCarousel(carouselTitle: "Romance");
  let fantasyCarousel = AnimeCarousel(carouselTitle: "Fantasy");
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  func configureAnimes(with animes: AnimesResponse) {
    popularCarousel.carouselAnimes = animes;
    romanceCarousel.carouselAnimes = animes;
    fantasyCarousel.carouselAnimes = animes;
    configurePopularCarousel();
    configureFantasyCarousel();
    configureRomanceCarousel();
    loading.stopAnimating();
  };
};

extension HomeView {
  private func configureLayout() {
    configureHighlightAnime();
    configureHighlightPlayButton();
    configureIsAvailableText();
    configureHighlightAnimeTitle();
    configureLoading();
  };
  
  private func configureHighlightAnime() {
    addSubview(highlightAnime);
    
    highlightAnime.translatesAutoresizingMaskIntoConstraints = false;
    highlightAnime.contentMode = .scaleAspectFill;
    highlightAnime.clipsToBounds = true;
    highlightAnime.layer.cornerRadius = 30;
    highlightAnime.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner];
    highlightAnime.image = UIImage(named: "AotBanner");
    
    NSLayoutConstraint.activate([
      highlightAnime.topAnchor.constraint(equalTo: topAnchor),
      highlightAnime.leadingAnchor.constraint(equalTo: leadingAnchor),
      highlightAnime.trailingAnchor.constraint(equalTo: trailingAnchor),
      highlightAnime.heightAnchor.constraint(equalToConstant: 400),
      highlightAnime.widthAnchor.constraint(equalTo: widthAnchor)
    ]);
  };
  
  private func configureHighlightPlayButton() {
    addSubview(highlightPlayButton);
    
    highlightPlayButton.translatesAutoresizingMaskIntoConstraints = false;
    highlightPlayButton.backgroundColor = .white;
    highlightPlayButton.layer.cornerRadius = 30;
    highlightPlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal);
    highlightPlayButton.tintColor = .black;
    
    NSLayoutConstraint.activate([
      highlightPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      highlightPlayButton.topAnchor.constraint(equalTo: highlightAnime.bottomAnchor, constant: -40),
      highlightPlayButton.widthAnchor.constraint(equalToConstant: 60),
      highlightPlayButton.heightAnchor.constraint(equalToConstant: 60)
    ]);
  };
  
  private func configureIsAvailableText() {
    addSubview(isAvailableText);
    
    isAvailableText.translatesAutoresizingMaskIntoConstraints = false;
    isAvailableText.textColor = .gray;
    isAvailableText.font = .systemFont(ofSize: 22, weight: .regular);
    isAvailableText.text = "Já Disponível";
    isAvailableText.textAlignment = .center;
    
    NSLayoutConstraint.activate([
      isAvailableText.topAnchor.constraint(equalTo: highlightPlayButton.bottomAnchor, constant: 10),
      isAvailableText.leadingAnchor.constraint(equalTo: leadingAnchor),
      isAvailableText.trailingAnchor.constraint(equalTo: trailingAnchor),
      isAvailableText.heightAnchor.constraint(equalToConstant: 28)
    ]);
  };
  
  private func configureHighlightAnimeTitle() {
    addSubview(highlightAnimeTitle);
    
    highlightAnimeTitle.translatesAutoresizingMaskIntoConstraints = false;
    highlightAnimeTitle.textColor = .white;
    highlightAnimeTitle.font = .systemFont(ofSize: 32, weight: .semibold);
    highlightAnimeTitle.text = "Attack on Titan";
    highlightAnimeTitle.textAlignment = .center;
    
    NSLayoutConstraint.activate([
      highlightAnimeTitle.topAnchor.constraint(equalTo: isAvailableText.bottomAnchor, constant: 10),
      highlightAnimeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      highlightAnimeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      highlightAnimeTitle.heightAnchor.constraint(equalToConstant: 38)
    ]);
  };
  
  private func configurePopularCarousel() {
    addSubview(popularCarousel);
    
    popularCarousel.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      popularCarousel.topAnchor.constraint(equalTo: highlightAnimeTitle.bottomAnchor, constant: 20),
      popularCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
      popularCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
      popularCarousel.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  private func configureFantasyCarousel() {
    addSubview(fantasyCarousel);
    
    fantasyCarousel.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      fantasyCarousel.topAnchor.constraint(equalTo: popularCarousel.bottomAnchor, constant: 80),
      fantasyCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
      fantasyCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
      fantasyCarousel.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  private func configureRomanceCarousel() {
    addSubview(romanceCarousel);
    
    romanceCarousel.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      romanceCarousel.topAnchor.constraint(equalTo: fantasyCarousel.bottomAnchor, constant: 80),
      romanceCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
      romanceCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
      romanceCarousel.heightAnchor.constraint(equalToConstant: 200),
      romanceCarousel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -60)
    ]);
  };
  
  private func configureLoading() {
    addSubview(loading);
    
    loading.translatesAutoresizingMaskIntoConstraints = false
    loading.color = .white
    loading.startAnimating();
        
    NSLayoutConstraint.activate([
      loading.topAnchor.constraint(equalTo: highlightAnimeTitle.bottomAnchor, constant: 200),
      loading.leadingAnchor.constraint(equalTo: leadingAnchor),
      loading.trailingAnchor.constraint(equalTo: trailingAnchor),
      loading.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
};
