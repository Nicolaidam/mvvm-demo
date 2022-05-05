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

public struct Screen2VMEnvironment {
    var apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public class Screen2VM: ObservableObject {

    var environment: SystemEnvironment<Screen2VMEnvironment>
    
    public init(environment: SystemEnvironment<Screen2VMEnvironment>) {
        self.environment = environment
    }
    
    func close() {
        
    }
}
