//
//  ArticleListPresenterTests.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/30.
//

@testable import Article
import DomainModel
import Foundation
@testable import MockEnvironment
import XCTest

@MainActor
final class ArticleListPresenterTests: XCTestCase {
    var presenter: ArticleListPresenter!
    var router: MockRouter!
    var articleListGetInteractor: MockArticleListGetInteractor!
    
    let article = ArticleModel(id: "id", title: "title", url: .init(string: "https://hoge.com")!)
    let error = NSError(domain: "error", code: -1)
    
    override func setUp() async throws {
        try await super.setUp()
        
        let environment = MockEnvironment()
        articleListGetInteractor = environment.articleListGetInteractor as? MockArticleListGetInteractor
        router = .init()
        
        presenter = .init(router: router, environment: environment)
    }
    
    func test_getArticleList_articleListGetInteractorから成功が返却されたとき() async {
        async let result: Void = await presenter.getArticleList(of: "test")
        articleListGetInteractor.executeResult = { [self] in
            XCTAssertEqual(presenter.uiState.isDisplayProgressView, true)
            return .success([article])
        }
        
        await result
        XCTAssertEqual(presenter.uiState.articleList, [article])
        XCTAssertEqual(presenter.uiState.isDisplayProgressView, false)
    }
    
    func test_getArticleList_articleListGetInteractorから失敗が返却されたとき() async {
        async let result: Void = await presenter.getArticleList(of: "test")
        articleListGetInteractor.executeResult = { [self] in
            XCTAssertEqual(presenter.uiState.isDisplayProgressView, true)
            return .failure(.connectionError(error))
        }
        
        await result
        XCTAssertEqual(presenter.uiState.error, .articleListGetError(.connectionError(error)))
        XCTAssertEqual(presenter.uiState.isDisplayProgressView, false)
    }
    
    func test_didSelect_呼ばれたとき() async {
        await presenter.didSelect(of: article)
        
        XCTAssertEqual(router.navigationOutput, .articleDetail(article))
    }
}

extension ArticleListPresenterTests {
    final class MockRouter: ArticleListWireframe {
        var navigationOutput: ArticleListDestination!
        func navigation(to destination: ArticleListDestination) {
            navigationOutput = destination
        }
    }
}
