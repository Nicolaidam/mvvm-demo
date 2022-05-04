//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import APIClient
import CombineSchedulers
import Foundation
import Screen1
import Model

public class AppCoreVM: ObservableObject {
    
    @Published var person: Person? = nil
    @Published var count: Int = 0
    @Published var screen1: Screen1VM?
    
    let apiClient: APIClient
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(apiClient: APIClient, mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.apiClient = apiClient
        self.mainQueue = mainQueue
    }

    func countUp() {
        self.count += 1
    }
    
    func navigateToScreen1() {
        self.screen1 = .init(apiClient: apiClient, count: count)
    }
    
    func onDismiss() {
        self.screen1 = nil
    }
}

