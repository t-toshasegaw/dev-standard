//
//  View+Extension.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/31.
//

import SwiftUI

public extension View {
    /// - Important: After this alert disappears, should set `error`  to `nil`.
    func errorAlert(
        error: (some LocalizedError)?,
        onDismiss: @escaping () -> Void
    ) -> some View {
        alert(
            isPresented: .init(get: {
                error != nil
            }, set: { _ in
                onDismiss()
            }),
            error: error
        ) { _ in
        } message: { error in
            Text(error.failureReason ?? "")
        }
    }
}