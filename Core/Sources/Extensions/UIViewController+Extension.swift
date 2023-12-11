//
//  UIViewController+Extension.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import SwiftUI

public extension UIViewController {
    func addSwiftUIChild(_ childView: some View) {
        let hostingVC = UIHostingController(rootView: childView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
        hostingVC.didMove(toParent: self)
    }
}
