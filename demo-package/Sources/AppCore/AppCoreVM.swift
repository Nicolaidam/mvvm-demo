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
    
    @Published var person: Person? = nil
    @Published var count: Int = 0
    @Published var screen1Sheet: Screen1VM?
    @Published var screen1NavigationLink: Screen1VM?
    @Published var showError = false
    let environment: SystemEnvironment<AppCoreVMEnvironment>
    var cancellables: Set<AnyCancellable> = []
    
    public init(environment: SystemEnvironment<AppCoreVMEnvironment>) {
        self.environment = environment
    }
    
    func countUp() {
        self.count += 1
    }
    
    func navigateToScreen1Sheet() {
        
        self.screen1Sheet = Screen1VM(environment: self.environment.map { .init(apiClient: $0.apiClient) }, count: self.count)
        
        setupSheet1SheetPublishers()
    }
    
    func navigateToScreen1NavigationLink() {
        
        self.screen1NavigationLink = Screen1VM(environment: self.environment.map { .init(apiClient: $0.apiClient) }, count: self.count)
        
        setupSheet1NavigationLinkPublishers()
    }
    
    func onDismissScreen1Sheet() {
        self.screen1Sheet = nil
    }
    
    func onDismissScreen1NavigationLink() {
        self.screen1NavigationLink = nil
    }
    
    func fetchPerson() {
        self.environment
            .apiClient
            .fetchPerson()
            .receive(on: environment.mainQueue)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.showError = true
                    case .finished:
                        print("Publisher is finished")
                    }
                },
                receiveValue: { [weak self] person in
                    self?.person = person
                })
            .store(in: &cancellables)
    }
    
    func setupSheet1SheetPublishers() {
        self.screen1Sheet?.$count
            .sink(receiveValue: { [weak self] value in
                self?.count = value
            })
            .store(in: &cancellables)
        
        self.screen1Sheet?.$close
            .sink(receiveValue: { [weak self] value in
                if value {
                    self?.onDismissScreen1Sheet()
                }
            })
            .store(in: &cancellables)
        
        self.screen1Sheet?.$screen2.sink(receiveValue: { [weak self] screen2vm in
            
            screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in
                
                if bool {
                    self?.screen1Sheet = nil
                }
            })
            .store(in: &self!.cancellables)
        })
        .store(in: &cancellables)
    }
    
    func setupSheet1NavigationLinkPublishers() {
        self.screen1NavigationLink?.$count
            .sink(receiveValue: { [weak self] value in
                self?.count = value
            })
            .store(in: &cancellables)
        
        self.screen1NavigationLink?.$close
            .sink(receiveValue: { [weak self] value in
                if value {
                    self?.onDismissScreen1NavigationLink()
                }
            })
            .store(in: &cancellables)
        
        self.screen1NavigationLink?.$screen2.sink(receiveValue: { [weak self] screen2vm in
            
            screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in
                
                if bool {
                    self?.screen1Sheet = nil
                }
            })
            .store(in: &self!.cancellables)
        })
        .store(in: &cancellables)
    }
}

