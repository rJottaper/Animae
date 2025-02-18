//
//  WatchAnimeViewTests.swift
//  AnimaeTests
//
//  Created by João Pedro Rocha on 17/02/25.
//

import XCTest
@testable import Animae

final class WatchAnimeViewTests: XCTestCase {
  var watchAnimeView: WatchAnimeView!

  override func setUpWithError() throws {
    watchAnimeView = WatchAnimeView();
  };

  override func tearDownWithError() throws {
    watchAnimeView = nil;
  };
  
  func testYoutubeViewIsSubview() throws {
    XCTAssertTrue(watchAnimeView.subviews.contains(watchAnimeView.youtubeView), "A youtubeView não foi adicionada como subview.");
  };
  
  func testYoutubeViewConstraints() throws {
    let constraints = watchAnimeView.constraints;
    
    let expectedConstraints = [
      watchAnimeView.youtubeView.topAnchor.constraint(equalTo: watchAnimeView.topAnchor),
      watchAnimeView.youtubeView.leadingAnchor.constraint(equalTo: watchAnimeView.leadingAnchor),
      watchAnimeView.youtubeView.trailingAnchor.constraint(equalTo: watchAnimeView.trailingAnchor),
      watchAnimeView.youtubeView.bottomAnchor.constraint(equalTo: watchAnimeView.bottomAnchor)
    ];
    
    XCTAssertEqual(constraints.count, 4, "Número incorreto de constraints configuradas.");
    
    for expectedConstraint in expectedConstraints {
      XCTAssertTrue(
        constraints.contains { $0.firstAnchor == expectedConstraint.firstAnchor && $0.secondAnchor == expectedConstraint.secondAnchor },
        "Uma das constraints está faltando ou não está configurada corretamente."
      );
    };
  };
};
