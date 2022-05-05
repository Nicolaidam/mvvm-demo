//
//  File.swift
//
//
//  Created by Nicolai Dam on 05/05/2022.
//

import CombineSchedulers
import Foundation

@dynamicMemberLookup
public struct SystemEnvironment<Environment> {
    public var mainQueue: AnySchedulerOf<DispatchQueue>
    public var date: () -> Date
    public var locale: Locale
    public var timeZone: TimeZone
    public var calendar: Calendar
    public var environment: Environment
//    public var localization: LocalizationsWrapper
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<Environment, Value>) -> Value {
        get { environment[keyPath: keyPath] }
        set { environment[keyPath: keyPath] = newValue }
    }
    /// Creates a live system environment with the wrapped environment provided.
    ///
    /// - Parameter environment: An environment to be wrapped in the system environment.
    /// - Returns: A new system environment.
    public static func live(environment: Environment) -> Self {
        return Self(
            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
            date: Date.init,
            locale: Locale(identifier: "da_DK"),
            timeZone: .autoupdatingCurrent,
            calendar: Calendar(identifier: .gregorian),
            environment: environment
        )
    }
    /// Transforms the underlying wrapped environment.
    public func map<NewEnvironment>(
        _ transform: @escaping (Environment) -> NewEnvironment
    ) -> SystemEnvironment<NewEnvironment> {
        .init(
            mainQueue: mainQueue,
            date: date,
            locale: locale,
            timeZone: timeZone,
            calendar: calendar,
            environment: transform(environment)
        )
    }
}


