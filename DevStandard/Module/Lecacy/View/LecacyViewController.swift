//
//  LecacyViewController.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import UIKit

final class LecacyViewController: UIViewController {
    private let text: String
    
    @IBOutlet private weak var textLabel: UILabel!
    
    init(text: String) {
        self.text = text
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
