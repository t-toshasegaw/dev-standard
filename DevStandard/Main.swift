//
//  DevStandardApp.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Enviroment
import SwiftUI

@main
struct Main: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ArticleListViewController()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        //  NavigationBarの背景色の設定
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return true
    }
}

struct ArticleListViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let view = AppEnviroment().resolve(ViewDescriptor.ArticleListDescriptor())
        
        return UINavigationController(rootViewController: view)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
