@testable import Article
import DomainModel
import Foundation
@testable import MockEnvironment
import Nimble
import Quick

final class ArticleListPresenterTests: AsyncSpec {
    override class func spec() {
        var presenter: ArticleListPresenter!
        var router: MockArticleListRouter!
        var articleListGetInteractor: MockArticleListGetInteractor!
        
        let article = ArticleModel(id: "id", title: "title", url: .init(string: "https://hoge.com")!)
        let error = NSError(domain: "error", code: -1)
        
        beforeEach {
            let environment = MockEnvironment()
            articleListGetInteractor = environment.articleListGetInteractor as? MockArticleListGetInteractor
            
            router = await .init()
            presenter = await ArticleListPresenter(
                router: router,
                environment: environment
            )
        }
        
        describe("getArticleList") {
            context("articleListGetInteractorから成功が返却されたとき") {
                beforeEach {
                    articleListGetInteractor.executeResult = .success([article])
                    await presenter.getArticleList(of: "test")
                }
                
                it("articleListが更新される") {
                    let articleList = await presenter.uiState.articleList
                    expect(articleList) == [article]
                }
                
                it("isDisplayProgressViewがfalseで更新される") {
                    let isDisplayProgressView = await presenter.uiState.isDisplayProgressView
                    expect(isDisplayProgressView) == false
                }
            }
            
            context("articleListGetInteractorから失敗が返却されたとき") {
                beforeEach {
                    articleListGetInteractor.executeResult = .failure(.connectionError(error))
                    await presenter.getArticleList(of: "test")
                }
                
                it("articleListErrorが更新される") {
                    let articleListError = await presenter.articleListError
                    expect(articleListError) == .articleListGetError(.connectionError(error))
                }
                
                it("isDisplayProgressViewがfalseで更新される") {
                    let isDisplayProgressView = await presenter.uiState.isDisplayProgressView
                    expect(isDisplayProgressView) == false
                }
            }
        }
        
        describe("didSelect") {
            beforeEach {
                await presenter.didSelect(of: article)
            }
            
            it("navigationが.articleDetailで呼ばれる") {
                let destination = await router.navigationOutput!
                expect(destination) == .articleDetail(article)
            }
        }
    }
}

extension ArticleListPresenterTests {
    final class MockArticleListRouter: ArticleListWireframe {
        var navigationOutput: ArticleListDestination!
        func navigation(to destination: ArticleListDestination) {
            navigationOutput = destination
        }
    }
}
