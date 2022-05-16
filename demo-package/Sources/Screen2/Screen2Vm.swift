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

public struct Screen2State: Equatable {
    var closeTapped = false
    
    public init(closeTapped: Bool = false) {
        self.closeTapped = closeTapped
    }
}

public enum Screen2Action {
    case onAppear
    case closeButtonTapped
}

public extension Screen2 {
    class ViewModel: GenericViewModel {
                
        public var state: Screen2State
        public var environment: AppEnvironment
        
        public init(state: Screen2State, environment: AppEnvironment) {
            self.state = state
            self.environment = environment
        }
        
        public func trigger(_ action: Screen2Action) {
            switch action {
            case .closeButtonTapped:
                self.state.closeTapped = false
            case .onAppear:
                return
            }
        }
    }
}
