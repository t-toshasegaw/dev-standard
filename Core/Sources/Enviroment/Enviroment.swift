//
//  Enviroment.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

@MainActor
public protocol Enviroment {
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output
}
