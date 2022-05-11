//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import Combine
import CombineSchedulers
import Model

public extension APIClient {
    static let mockSuccess = Self.init(fetchPerson: {
        Just(Person(name: "Henrik Olsen", age: 99))
        .setFailureType(to: GenericNetworkError.self)
        .delay(for: 2, scheduler: AnySchedulerOf<DispatchQueue>.main)
        .eraseToAnyPublisher()
    })
    static let mockError = Self.init(fetchPerson: {
        Fail(error: GenericNetworkError.error("error"))
        .delay(for: 2, scheduler: AnySchedulerOf<DispatchQueue>.main)
        .eraseToAnyPublisher()
    })
}

public enum GenericNetworkError: Error, Equatable {
    case urlError(URLError)
    case error(String)
}
