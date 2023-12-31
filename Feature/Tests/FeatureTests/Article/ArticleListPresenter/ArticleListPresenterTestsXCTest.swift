//
//  ArticleListPresenterTestsXCTest.swift
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
final class ArticleListPresenterTestsXCTest: XCTestCase {
    let article = ArticleModel(id: "id", title: "title", url: .init(string: "https://hoge.com")!)
    let error = NSError(domain: "error", code: -1)
    
    func test_getArticleList_articleListGetInteractorから成功が返却されたとき() async {
        let environment = MockEnvironment()
        let articleListGetInteractor = environment.articleListGetInteractor as! MockArticleListGetInteractor
        let router = MockArticleListRouter()
        let presenter = ArticleListPresenter(router: router, environment: environment)
        
        // articleListGetInteractorから値が返却されるまではisDisplayProgressViewがtureになる
        articleListGetInteractor.executeCalled = {
            XCTAssertEqual(presenter.uiState.isDisplayProgressView, true)
        }
        articleListGetInteractor.executeResult = .success([article])
        await presenter.getArticleList(of: "test")
        
        XCTAssertEqual(presenter.uiState.articleList, [article])
        XCTAssertEqual(presenter.uiState.isDisplayProgressView, false)
    }
    
    func test_getArticleList_articleListGetInteractorから失敗が返却されたとき() async {
        let environment = MockEnvironment()
        let articleListGetInteractor = environment.articleListGetInteractor as! MockArticleListGetInteractor
        let router = MockArticleListRouter()
        let presenter = ArticleListPresenter(router: router, environment: environment)
        
        // articleListGetInteractorから値が返却されるまではisDisplayProgressViewがtureになる
        articleListGetInteractor.executeCalled = {
            XCTAssertEqual(presenter.uiState.isDisplayProgressView, true)
        }
        articleListGetInteractor.executeResult = .failure(.connectionError(error))
        await presenter.getArticleList(of: "test")
        
        XCTAssertEqual(presenter.uiState.articleListError, .articleListGetError(.connectionError(error)))
        XCTAssertEqual(presenter.uiState.isDisplayProgressView, false)
    }
    
    func test_didSelect_呼ばれたとき() async {
        let environment = MockEnvironment()
        let router = MockArticleListRouter()
        let presenter = ArticleListPresenter(router: router, environment: environment)
        
        presenter.didSelect(of: article)
        
        XCTAssertEqual(router.navigationOutput, .articleDetail(article))
    }
}

extension ArticleListPresenterTestsXCTest {
    final class MockArticleListRouter: ArticleListWireframe {
        var navigationOutput: ArticleListDestination!
        func navigation(to destination: ArticleListDestination) {
            navigationOutput = destination
        }
    }
}
