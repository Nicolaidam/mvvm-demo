////
////  File.swift
////  
////
////  Created by Nicolai Dam on 11/05/2022.
////
//
//import APIClient
//import Combine
//import CombineSchedulers
//import Model
//import Shared
//import XCTest
//import Foundation
//@testable import Screen1
//
//final class Screen1Tests: XCTestCase {
//    let scheduler = AnySchedulerOf<DispatchQueue>.immediate
//    
//    func testApiCallSuccess() throws {
//        
//        let person = Person(name: "John for faen", age: 97)
//        var env = AppEnvironment.test(environment: Screen1VMEnvironment(apiClient: .mockSuccess), testScheduler: scheduler)
//        env.apiClient.fetchPerson = {
//            Just(person)
//                .setFailureType(to: GenericNetworkError.self)
//                .eraseToAnyPublisher()
//        }
//        
//        let vm = Screen1VM.init(environment: env, count: 0)
//
//        #warning("How do I test that loading is immediatly set to true, and false after api call is returned?")
//        vm.fetchPerson()
//        
//        XCTAssertEqual(vm.isLoading, false)
//        XCTAssertEqual(vm.person, person)
//        XCTAssertEqual(vm.showError, false)
//    }
//    
//    func testApiCallFailure() throws {
//        
//        let error = GenericNetworkError.error("hey john")
//        var env = AppEnvironment.test(environment: Screen1VMEnvironment(apiClient: .mockSuccess), testScheduler: scheduler)
//        env.apiClient.fetchPerson = {
//            Fail.init(error: error)
//                .eraseToAnyPublisher()
//        }
//        
//        let vm = Screen1VM.init(environment: env, count: 0)
//
//        #warning("How do I test that loading is immediatly set to true, and false after api call is returned?")
//        vm.fetchPerson()
//        
//        XCTAssertEqual(vm.isLoading, false)
//        XCTAssertEqual(vm.person, nil)
//        XCTAssertEqual(vm.showError, true)
//    }
//}
//
//
