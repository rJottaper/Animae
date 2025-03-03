//
//  MyAnimesViewTests.swift
//  AnimaeTests
//
//  Created by João Pedro Rocha on 20/02/25.
//

import XCTest
import CoreData
@testable import Animae

final class MyAnimesViewTests: XCTestCase {
  var myAnimesView: MyAnimesView!
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func setUpWithError() throws {
    myAnimesView = MyAnimesView();
  };

  override func tearDownWithError() throws {
    myAnimesView = nil;
  };
  
  func testIfWasAddedSubview() throws {
    XCTAssertTrue(myAnimesView.subviews.contains(myAnimesView.myAnimesTableView), "Tableview não foi adicionada como subview");
  };
  
  func testIfConstraintsAreSet() throws {
    let constraints = myAnimesView.constraints.filter { $0.firstItem === myAnimesView.myAnimesTableView };
    
    XCTAssertEqual(constraints.count, 4, "Constraints não foram setados corretamente");
  };
  
  func testDefaultSizeTableView() throws {
    let size = myAnimesView.tableView(myAnimesView.myAnimesTableView, numberOfRowsInSection: 0);
    
    XCTAssertEqual(size, 0, "Tableview deve retornar vazia.");
  };
  
  func testDefaultHeightTableView() throws {
    let height = myAnimesView.tableView(myAnimesView.myAnimesTableView, heightForRowAt: IndexPath(row: 0, section: 0));
    
    XCTAssertEqual(height, 180, "TableView deve ter por default 180 de altura.");
  };
  
  func testCellForRowAt() throws {
    let dummyAnimes = [
      AnimeModel(from: Anime(id: 1, title: "Anime 1", episodes: 12, synopsis: "Synopsis 1", url: "https://example.com/1", imageUrl: "https://example.com/image1.jpg"), context: context.self),
      AnimeModel(from:  Anime(id: 2, title: "Anime 2", episodes: 24, synopsis: "Synopsis 2", url: "https://example.com/2", imageUrl: "https://example.com/image2.jpg"), context: context.self)
    ];
    
    myAnimesView.animes = dummyAnimes;
    
    let indexPath = IndexPath(row: 0, section: 0);
    let cell = myAnimesView.tableView(myAnimesView.myAnimesTableView, cellForRowAt: indexPath) as? SearchAnimeCell;
    cell?.configure(anime: Anime(from: dummyAnimes[indexPath.row]));
    
    XCTAssertEqual(cell, cell as SearchAnimeCell?, "Cell não foi configurado corretamente");
  };
};
