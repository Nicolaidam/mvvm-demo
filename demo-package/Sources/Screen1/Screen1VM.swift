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

public enum Screen1Action {
    case fetchPerson
    case countUp
    case navigateToScreen2
    case navigationChangedScreen2
    case closeSheet
}

extension Screen1 {
    
    public class ViewModel: ObservableObject {
        
        public let environment: AppEnvironment
        private var cancellables: Set<AnyCancellable> = []
        @Published public var person: Person?
        @Published public var count: Int = 0
        @Published public var isLoading: Bool = false
        @Published public var screen2: Screen2State?
        @Published public var close = false
        @Published public var showError = false
        
        public init(environment: AppEnvironment, count: Int) {
            self.environment = environment
            self.count = count
        }
        
        public func trigger(_ action: Screen1Action) {
            switch action {
                
            case .fetchPerson:
                self.isLoading = true
                self.environment
                    .apiClient
                    .fetchPerson()
                    .receive(on: environment.mainQueue)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            self.showError = true
                            self.isLoading = false
                        case .finished:
                            print("Publisher is finished")
                            self.isLoading = false
                        }
                    }, receiveValue: { [weak self] person in
                        self?.person = person
                    })
                    .store(in: &cancellables)
            case .countUp:
                
                self.count += 1
                
                
            case .navigateToScreen2:
                self.screen2 = .init()
            case .navigationChangedScreen2:
                self.screen2 = nil
            case .closeSheet:
                self.close = true
            }
        }
    }
}
