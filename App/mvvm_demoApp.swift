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
    var body: some Scene {
        WindowGroup {
            AppCore(vm: .init(environment: .live(environment: .init(apiClient: .mockError))))
        }
    }
}
