//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import APIClient
import Combine
import Foundation
import Model
import Shared
import Screen2

public struct Screen1VMEnvironment {
    var apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public class Screen1VM: ObservableObject {
    @Published public var person: Person?
    @Published public var count: Int
    @Published public var isLoading: Bool = false
    @Published public var screen2: Screen2VM?
    @Published public var close = false
    var environment: SystemEnvironment<Screen1VMEnvironment>
    var cancellables: Set<AnyCancellable> = []
    
    public init(environment: SystemEnvironment<Screen1VMEnvironment>, count: Int) {
        self.environment = environment
        self.count = count
    }
    
    func fetchPerson() {
        #warning("TODO: lav error handling + tests")
        self.isLoading = true
        self.environment
            .apiClient
            .fetchPerson()
            .sink { [weak self] person in
                self?.person = person
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func countUp() {
        self.count += 1
    }
    
    func navigateToScreen2() {
        self.screen2 = .init(environment: self.environment.map { .init(apiClient: $0.apiClient) })
    }
    
    func navigationChangedScreen2() {
        self.screen2 = nil
    }
    
    func closeSheet() {
        self.close = true
    }
}
