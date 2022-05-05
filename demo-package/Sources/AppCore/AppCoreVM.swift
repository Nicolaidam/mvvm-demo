//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import APIClient
import CombineSchedulers
import Combine
import Foundation
import Screen1
import Model
import Shared

public struct AppCoreVMEnvironment {
    var apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public class AppCoreVM: ObservableObject {
    
    let environment: SystemEnvironment<AppCoreVMEnvironment>
    @Published var person: Person? = nil
    @Published var count: Int = 0
    @Published var screen1: Screen1VM?
    var cancellables: Set<AnyCancellable> = []
    
    public init(environment: SystemEnvironment<AppCoreVMEnvironment>) {
        self.environment = environment
    }
    
    func countUp() {
        self.count += 1
    }
    
    func navigateToScreen1() {
        self.screen1 = Screen1VM(environment: self.environment.map { .init(apiClient: $0.apiClient) }, count: self.count)
    }
    
    func onDismiss() {
        self.screen1 = nil
    }
    
    func fetchPerson() {
        self.environment
            .apiClient
            .fetchPerson()
            .sink { [weak self] person in
                self?.person = person
            }
            .store(in: &cancellables)
    }
}

