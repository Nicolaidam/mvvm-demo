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

public struct Screen1VMEnvironment {
    var apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public class Screen1VM: ObservableObject {
    @Published var person: Person?
    @Published var count: Int
    @Published var isLoading: Bool = false
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
}
