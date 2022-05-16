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

public enum Screen2Action {
    case onAppear
    case closeButtonTapped
}

extension Screen2 {
    
    public class ViewModel: GenericViewModel {
        
        @Published public var closeTapped = false
        public var environment: AppEnvironment
        
        public init(environment: AppEnvironment) {
            self.environment = environment
        }
        
        public func trigger(_ action: Screen2Action) {
            switch action {
            case .closeButtonTapped:
                
                self.closeTapped = true
            case .onAppear:
                return
            }
        }
    }
}
