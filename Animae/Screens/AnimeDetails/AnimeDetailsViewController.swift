//
//  AnimeDetailsViewController.swift
//  Animae
//
//  Created by João Pedro Rocha on 18/11/24.
//

import UIKit
import CoreData
import youtube_ios_player_helper
import UserNotifications

class AnimeDetailsViewController: UIViewController {
  let scrollView = UIScrollView();
  let animeDetailsView = AnimeDetailsView();
  
  var anime: Anime?;
  
  private var animeDetailsViewModel: AnimeDetailsViewModel;
  
  init(anime: Anime?) {
    self.animeDetailsViewModel = AnimeDetailsViewModel(anime: anime);
    super.init(nibName: nil, bundle: nil);
    self.animeDetailsViewModel.onUpdate = { [weak self] in
      self?.configureHeader();
    };
  };
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
   
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureHeader();
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3);
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
    
    configureScrollView();
    configureAnimeDetailsView();
    
    animeDetailsView.delegate = self;
  };
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    
    animeDetailsViewModel.checkIfAnimeIsSaved();
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    if let appearance = navigationController?.navigationBar.standardAppearance {
      appearance.backgroundColor = .clear;
      navigationController?.navigationBar.standardAppearance = appearance;
      navigationController?.navigationBar.scrollEdgeAppearance = appearance;
    };
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    scrollView.contentInset = UIEdgeInsets(top: -view.safeAreaInsets.top, left: 0, bottom: 0, right: 0);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  func configure(with anime: Anime?) {
    if let animeImage = anime?.imageUrl, let animeTitle = anime?.title, let animeDescription = anime?.synopsis {
      animeDetailsView.animeBanner.downloaded(from: animeImage);
      animeDetailsView.animeTitle.text = animeTitle;
      animeDetailsView.animeDescription.text = animeDescription;
      self.anime = anime;
    };
  };
  
  @objc private func isFavorite() {
    guard let anime = anime else { return }
    
    if animeDetailsViewModel.isSaved {
      let alert = UIAlertController(title: "Ei Nerd", message: "Deseja remover \(anime.title) da sua lista de favoritos?", preferredStyle: .alert);
      alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { [weak self] action in
        guard let self = self else { return }
        
        self.animeDetailsViewModel.toggleFavorite();
      }));
      alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel));
      
      present(alert, animated: true);
    } else {
      animeDetailsViewModel.toggleFavorite();
    };
  };
};

extension AnimeDetailsViewController: UIScrollViewDelegate, AnimeDetailsViewDelegate {
  // ScrollView
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -100 {
      SceneDelegate.shared?.popViewController();
    };
    
    if scrollView.contentOffset.y > 650 {
      navigationItem.title = anime?.title;
    };
    
    if scrollView.contentOffset.y < 650 {
      navigationItem.title = ""
    };
  };
  
  // Buttons
  func tapWatchButton() {
    let watchAnimeViewController = WatchAnimeViewController();
    guard let trailerId = anime?.trailerUrl else {
      return watchAnimeViewController.configureVideo(withId: "");
    };
    
    watchAnimeViewController.configureVideo(withId: trailerId);
    
    present(watchAnimeViewController, animated: true);
  };
  
  func tapRemindButton() {
    let notificationCenter = UNUserNotificationCenter.current();
    
    notificationCenter.getNotificationSettings { settings in
      switch settings.authorizationStatus {
      case .authorized:
        DispatchQueue.main.async {
          self.sendNotification();
        };
      case .denied:
        DispatchQueue.main.async {
          self.openConfig();
        }
      case .notDetermined:
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
          if didAllow {
            DispatchQueue.main.async {
              self.sendNotification();
            }
          };
        };
      default:
        return
      };
    };
  };
  
  private func sendNotification() {
    let identifier = UUID().uuidString;
    let notificationCenter = UNUserNotificationCenter.current();
    let content = UNMutableNotificationContent();
    
    content.title = "Lembrete Adicionado";
    content.body = "Foi adicionado um lembrete para assistir \(anime?.title ?? "") mais tarde";
    content.sound = .default;
    
    let calendar = Calendar.current;
    var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current);
    
    dateComponents.hour = calendar.component(.hour, from: Date());
    dateComponents.minute = calendar.component(.minute, from: Date());
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false);
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger);
    
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier]);
    notificationCenter.add(request) { error in
      if let error = error {
        print("Falha ao enviar notificação: \(error.localizedDescription)");
      };
    }
  };
  
  private func openConfig() {
    guard let settigsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    };
    
    if UIApplication.shared.canOpenURL(settigsUrl) {
      UIApplication.shared.open(settigsUrl);
    };
  };
};

// MARK: Layout
extension AnimeDetailsViewController {
  private func configureHeader() {
    let saveButton = UIImage(systemName: animeDetailsViewModel.isSaved ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular));
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: saveButton,
      style: .plain,
      target: self,
      action: #selector(isFavorite)
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
      
    ]);
  };
  
  private func configureAnimeDetailsView() {
    scrollView.addSubview(animeDetailsView);
    
    animeDetailsView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      animeDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      animeDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      animeDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      animeDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      animeDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
}
