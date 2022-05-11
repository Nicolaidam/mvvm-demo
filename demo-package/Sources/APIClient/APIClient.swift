//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import Combine
import Model

public struct APIClient {
    public var fetchPerson: () -> AnyPublisher<Person, GenericNetworkError>
}
