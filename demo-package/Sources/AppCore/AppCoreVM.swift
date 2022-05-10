//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import APIClient
import CombineSchedulers
import Combine
import Foundation
import Screen1
import Model
import Shared

public struct AppCoreVMEnvironment {
    var apiClient: APIClient
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public class AppCoreVM: ObservableObject {
    
    let environment: SystemEnvironment<AppCoreVMEnvironment>
    @Published var person: Person? = nil
    @Published var count: Int = 0
    @Published var screen1: Screen1VM?
    public var cancellables: Set<AnyCancellable> = []
    
    public init(environment: SystemEnvironment<AppCoreVMEnvironment>) {
        self.environment = environment
    }
    
    func countUp() {
        self.count += 1
    }
    
    func navigateToScreen1() {
        
        self.screen1 = Screen1VM(environment: self.environment.map { .init(apiClient: $0.apiClient) }, count: self.count)

        self.screen1?.$count
            .sink(receiveValue: { [weak self] value in
                self?.count = value
            })
            .store(in: &cancellables)
        
        self.screen1?.$close
            .sink(receiveValue: { [weak self] value in
                if value {
                    self?.onDismissScreen1()
                }
            })
            .store(in: &cancellables)
        
        self.screen1?.$screen2.sink(receiveValue: { [weak self] screen2vm in
            
            screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in
                
                if bool {
                    self?.screen1 = nil
                }
            })
            .store(in: &self!.cancellables)
        })
        .store(in: &cancellables)
    }
    
    func onDismissScreen1() {
        self.screen1 = nil
    }
    
    func fetchPerson() {
        self.environment
            .apiClient
            .fetchPerson()
            .sink { [weak self] person in
                self?.person = person
            }
            .store(in: &cancellables)
    }
}

