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
import SwiftUI

public class Screen1State: ObservableObject {
    
    @Published public var person: Person?
    @Published public var count: Int
    @Published public var isLoading: Bool = false
    @Published public var screen2: Screen2State?
    @Published public var close = false
    @Published public var showError = false
    
    public init(person: Person? = nil, count: Int, isLoading: Bool = false, screen2: Screen2State? = nil, close: Bool = false, showError: Bool = false) {
        self.person = person
        self.count = count
        self.isLoading = isLoading
        self.screen2 = screen2
        self.close = close
        self.showError = showError
    }
}

public enum Screen1Action {
    case fetchPerson
    case countUp
    case navigateToScreen2
    case navigationChangedScreen2
    case closeSheet
}

extension Screen1 {
    
    public class ViewModel: GenericViewModel {
        
        @ObservedObject public var state: Screen1State
        public let environment: AppEnvironment
        private var cancellables: Set<AnyCancellable> = []
        
        public init(initialState: Screen1State, environment: AppEnvironment) {
            self.state = initialState
            self.environment = environment
        }
        
        public func trigger(_ action: Screen1Action) {
            switch action {
                
            case .fetchPerson:
                self.state.isLoading = true
                self.environment
                    .apiClient
                    .fetchPerson()
                    .receive(on: environment.mainQueue)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            self.state.showError = true
                            self.state.isLoading = false
                        case .finished:
                            print("Publisher is finished")
                            self.state.isLoading = false
                        }
                    }, receiveValue: { [weak self] person in
                        self?.state.person = person
                    })
                    .store(in: &cancellables)
            case .countUp:
                
                self.state.count += 1
                
                
            case .navigateToScreen2:
                self.state.screen2 = .init()
            case .navigationChangedScreen2:
                self.state.screen2 = nil
            case .closeSheet:
                self.state.close = true
            }
        }
    }
}
