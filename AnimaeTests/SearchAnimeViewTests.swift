//
//  SearchAnimeViewTests.swift
//  AnimaeTests
//
//  Created by João Pedro Rocha on 19/02/25.
//

import XCTest
@testable import Animae

final class SearchAnimeViewTests: XCTestCase {
  var searchAnimeView: SearchAnimeView!

  override func setUpWithError() throws {
    searchAnimeView = SearchAnimeView();
  };

  override func tearDownWithError() throws {
    searchAnimeView = nil;
  };
  
  func testIfViewsAreSubview() throws {
    XCTAssertTrue(searchAnimeView.subviews.contains(searchAnimeView.searchAnimeTableView), "TableView não foi adicionada no layout");
    XCTAssertTrue(searchAnimeView.subviews.contains(searchAnimeView.loading), "Loading não foi adicionado no layout");
  };
  
  func testIfAllConstraintsWasAdded() throws {
    let tableViewConstraints = searchAnimeView.constraints.filter { $0.firstItem === searchAnimeView.searchAnimeTableView };
    let loadingConstraints = searchAnimeView.constraints.filter { $0.firstItem === searchAnimeView.loading };
    
    XCTAssertEqual(tableViewConstraints.count, 4, "TableView não recebeu todas as constraints esperadas.");
    XCTAssertEqual(loadingConstraints.count, 4, "Loading não recebeu todas as constraints esperadas.");
  };
  
  func testCellForRowAtIndexPath() throws {
    let dummyAnimes = [
        Anime(id: 1, title: "Anime 1", episodes: 12, synopsis: "Synopsis 1", url: "https://example.com/1", imageUrl: "https://example.com/image1.jpg"),
        Anime(id: 2, title: "Anime 2", episodes: 24, synopsis: "Synopsis 2", url: "https://example.com/2", imageUrl: "https://example.com/image2.jpg")
    ];
    
    searchAnimeView.animes = dummyAnimes

    let indexPath = IndexPath(row: 0, section: 0);
    let cell = searchAnimeView.tableView(searchAnimeView.searchAnimeTableView, cellForRowAt: indexPath) as? SearchAnimeCell;
    cell?.configure(anime: dummyAnimes[indexPath.row]);

    XCTAssertEqual(cell, cell as SearchAnimeCell?, "A célula deve ser do tipo SearchAnimeCell.");
  };

  
  func testHeightForRowAt() throws {
    let height = searchAnimeView.tableView(searchAnimeView.searchAnimeTableView, heightForRowAt: IndexPath(row: 0, section: 0))

    XCTAssertEqual(height, 180, "heightForRowAt deve ser 180.");
  };
  
  func testNumberOfRows() throws {
    let size = searchAnimeView.tableView(searchAnimeView.searchAnimeTableView, numberOfRowsInSection: 0);

    XCTAssertEqual(size, 0, "A lista deve retornar vazia.");
  };

  func testShouldCallStartLoading() throws {
    searchAnimeView.startLoading();
    
    XCTAssertTrue(Thread.isMainThread, "O método startLoading deve ser chamado na thread principal.");
  };
  
  func testShoudCallStopLoading() throws {
    searchAnimeView.stopLoading();
    
    XCTAssertTrue(Thread.isMainThread, "O método stopLoading deve ser chamado na thread principal.");
  };
};
