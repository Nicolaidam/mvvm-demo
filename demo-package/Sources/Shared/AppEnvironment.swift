//
//  File.swift
//
//
//  Created by Nicolai Dam on 05/05/2022.
//

import CombineSchedulers
import Foundation
import APIClient

public struct AppEnvironment {
    
    public var mainQueue: AnySchedulerOf<DispatchQueue>
    public var date: () -> Date
    public var locale: Locale
    public var timeZone: TimeZone
    public var calendar: Calendar
    public var apiClient: APIClient

    /// Creates a live system environment with the wrapped environment provided.
    ///
    /// - Parameter environment: An environment to be wrapped in the system environment.
    /// - Returns: A new system environment.
    public static func live() -> Self {
        return Self(
            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
            date: Date.init,
            locale: Locale(identifier: "da_DK"),
            timeZone: .autoupdatingCurrent,
            calendar: Calendar(identifier: .gregorian),
            apiClient: APIClient.mockSuccess
        )
    }
    
    public static func test(testScheduler: AnySchedulerOf<DispatchQueue>) -> Self {
        return Self(
            mainQueue: testScheduler,
            date: Date.init,
            locale: Locale(identifier: "da_DK"),
            timeZone: .autoupdatingCurrent,
            calendar: Calendar(identifier: .gregorian),
            apiClient: APIClient.mockSuccess
        )
    }
    
    public static func mock() -> Self {
        return Self(
            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
            date: Date.init,
            locale: Locale(identifier: "da_DK"),
            timeZone: .autoupdatingCurrent,
            calendar: Calendar(identifier: .gregorian),
            apiClient: APIClient.mockSuccess
        )
    }
}
