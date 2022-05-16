//
//  mvvm_demoApp.swift
//  mvvm-demo
//
//  Created by Nicolai Dam on 04/05/2022.
//

import AppCore
import SwiftUI

@main
struct mvvm_demoApp: App {
    @ObservedObject var appCoreState = AppCoreState()
    var body: some Scene {
        WindowGroup {
            AppCore(initialState: appCoreState, environment: .mock())
        }
    }
}
