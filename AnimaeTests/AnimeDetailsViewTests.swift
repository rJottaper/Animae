//
//  AnimeDetailsViewTests.swift
//  AnimaeTests
//
//  Created by João Pedro Rocha on 18/02/25.
//

import XCTest
@testable import Animae

class AnimeDetailsViewDelegateMock: AnimeDetailsViewDelegate {
  var didTapWatchButton = false
  var didTapRemindButton = false

  func tapWatchButton() {
    didTapWatchButton = true;
  };

  func tapRemindButton() {
    didTapRemindButton = true;
  };
};

final class AnimeDetailsViewTests: XCTestCase {
  var animeDetailsView: AnimeDetailsView!
  let delegateMock = AnimeDetailsViewDelegateMock();
  
  override func setUpWithError() throws {
    animeDetailsView = AnimeDetailsView();
  };

  override func tearDownWithError() throws {
    animeDetailsView = nil;
  };
  
  func testIfViewsAreSubview() throws {
    animeDetailsView.layoutSubviews();
    
    XCTAssertTrue(animeDetailsView.subviews.contains(animeDetailsView.animeBanner), "Anime Banner não foi adicionado como subview.");
    XCTAssertTrue(animeDetailsView.animeBanner.subviews.contains(animeDetailsView.shadowView), "Shadow View não foi adicionado como subview.");
    XCTAssertTrue(animeDetailsView.subviews.contains(animeDetailsView.animeTitle), "Anime Title não foi adicionado como subview.");
    XCTAssertTrue(animeDetailsView.subviews.contains(animeDetailsView.animeDescription), "Anime Description não foi adicionado como subview.");
    XCTAssertTrue(animeDetailsView.subviews.contains(animeDetailsView.watchButton), "Watch Button não foi adicionado como subview.");
    XCTAssertTrue(animeDetailsView.subviews.contains(animeDetailsView.remindButton), "Reminder Button não foi adicionado como subview.");
  };
  
  func testIfAllConstraintsWasAdded() throws {
    // HEIGHT não conta como constraints.
    
    let constraints = animeDetailsView.constraints;
    let bannerConstraints = animeDetailsView.constraints.filter { $0.firstItem === animeDetailsView.animeBanner };
    let titleConstraints = animeDetailsView.constraints.filter { $0.firstItem === animeDetailsView.animeTitle };
    let descriptionConstraints = animeDetailsView.constraints.filter { $0.firstItem === animeDetailsView.animeDescription };
    let watchButtonConstraints = animeDetailsView.constraints.filter { $0.firstItem === animeDetailsView.watchButton };
    let remindButtonConstraints = animeDetailsView.constraints.filter { $0.firstItem === animeDetailsView.remindButton };
    
    XCTAssertEqual(constraints.count, 16, "Anime Details não foi configurada corretamente");
    XCTAssertEqual(bannerConstraints.count, 3, "O banner não recebeu todas as constraints esperadas.");
    XCTAssertEqual(titleConstraints.count, 3, "O title não recebeu todas as constraints esperadas.");
    XCTAssertEqual(descriptionConstraints.count, 3, "A description não recebeu todas as constraints esperadas.");
    XCTAssertEqual(watchButtonConstraints.count, 3, "Watch Button não recebeu todas as constraints esperadas.");
    XCTAssertEqual(remindButtonConstraints.count, 4, "Remind Button não recebeu todas as constraints esperadas.");
  };
  
  func testWatchButtonTapped() throws {
    animeDetailsView.delegate = delegateMock;
    animeDetailsView.watchButtonTapped();
    
    XCTAssertTrue(delegateMock.didTapWatchButton, "tapWatchButton deve ser chamando quando o botão de assistir for tocado");
  };
  
  func testRemindButton() throws {
    animeDetailsView.delegate = delegateMock;
    animeDetailsView.remindButtonTapped();
    
    XCTAssertTrue(delegateMock.didTapRemindButton, "tapRemindButton deve ser chamando quando o botão de lembrar for tocado");
  };
};
