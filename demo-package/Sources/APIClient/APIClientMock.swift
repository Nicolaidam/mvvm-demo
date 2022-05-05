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
    static let mock = Self.init(fetchPerson: {
        Just(Person(name: "Henrik Olsen", age: 99))
        .delay(for: 2, scheduler: AnySchedulerOf<DispatchQueue>.main)
        .eraseToAnyPublisher()
    })
}
