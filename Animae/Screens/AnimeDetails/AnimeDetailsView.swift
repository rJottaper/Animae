//
//  AnimeDetailsView.swift
//  Animae
//
//  Created by João Pedro Rocha on 21/11/24.
//

import UIKit

protocol AnimeDetailsViewDelegate: AnyObject {
  func tapWatchButton();
};

class AnimeDetailsView: UIView {
  let animeBanner = UIImageView();
  let shadowView = UIView();
  let animeTitle = UILabel();
  let animeDescription = UILabel();
  let watchButton = ANButton(title: "Assistir Trailer", iconName: "play.fill")
  
  weak var delegate: AnimeDetailsViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    configureAnimeBanner();
    configureGradient();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension AnimeDetailsView {
  @objc func watchButtonTapped() {
    delegate?.tapWatchButton();
  };
};


// MARK: Layout
extension AnimeDetailsView {
  private func configureLayout() {
    configureAnimeBanner();
    configureAnimaTitle();
    configureAnimeDescription();
    configureWatchButton();
  };
  
  private func configureAnimeBanner() {
    addSubview(animeBanner);
    
    animeBanner.translatesAutoresizingMaskIntoConstraints = false;
    animeBanner.contentMode = .scaleToFill;
    
    NSLayoutConstraint.activate([
      animeBanner.topAnchor.constraint(equalTo: topAnchor),
      animeBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
      animeBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
      animeBanner.heightAnchor.constraint(equalToConstant: 600)
    ]);
  };
  
  private func configureGradient() {
    animeBanner.addSubview(shadowView);
    
    shadowView.translatesAutoresizingMaskIntoConstraints = false;
    shadowView.frame = animeBanner.bounds;
    
    let gradient = CAGradientLayer();
    gradient.frame = shadowView.bounds;
    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor];
    gradient.locations = [0.8, 1.0];

    shadowView.layer.insertSublayer(gradient, at: 0);
  };
  
  private func configureAnimaTitle() {
    addSubview(animeTitle);
    
    animeTitle.translatesAutoresizingMaskIntoConstraints = false;
    animeTitle.font = .systemFont(ofSize: 28, weight: .bold);
    animeTitle.textColor = .white;
    animeTitle.numberOfLines = 2;
    
    NSLayoutConstraint.activate([
      animeTitle.topAnchor.constraint(equalTo: animeBanner.bottomAnchor, constant: 20),
      animeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      animeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
    ]);
  };
  
  private func configureAnimeDescription() {
    addSubview(animeDescription);
    
    animeDescription.translatesAutoresizingMaskIntoConstraints = false;
    animeDescription.font = .systemFont(ofSize: 18, weight: .regular);
    animeDescription.textColor = .white;
    animeDescription.layer.opacity = 0.6;
    animeDescription.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      animeDescription.topAnchor.constraint(equalTo: animeTitle.bottomAnchor, constant: 20),
      animeDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      animeDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
    ]);
  };
  
  private func configureWatchButton() {
    addSubview(watchButton);
    
    watchButton.translatesAutoresizingMaskIntoConstraints = false;
    watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside);
    
    NSLayoutConstraint.activate([
      watchButton.topAnchor.constraint(equalTo: animeDescription.bottomAnchor, constant: 20),
      watchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      watchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      watchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      watchButton.heightAnchor.constraint(equalToConstant: 60)
    ]);
  };
};
