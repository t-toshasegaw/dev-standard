//
//  LecacyRouter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import Enviroment
import UIKit

final class LecacyRouter {
    let enviroment: Enviroment
    
    init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }
    
    static func assembleModules(
        with descriptor: ViewDescriptor.LecacyDescriptor,
        enviroment: Enviroment
    ) -> UIViewController {
        let view = LecacyViewController(text: descriptor.text)
        return view
    }
}
