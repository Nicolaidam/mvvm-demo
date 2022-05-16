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
import SwiftUI
import Shared

public enum AppCoreAction {
    case countUp
    case navigateToScreen1Sheet
    case navigateToScreen1NavigationLink
    case onDismissScreen1Sheet
    case navigationChangedScreen2
    case fetchPerson
    case setupSheet1SheetPublishers
    case setupSheet1NavigationLinkPublishers
}

extension AppCore  {
    
    public class ViewModel: GenericViewModel {
        
        public var environment: AppEnvironment
        var cancellables: Set<AnyCancellable> = []
        @Published public var person: Person? = nil
        @Published public var count: Int = 0
        @Published public var screen1Sheet: Screen1.ViewModel?
        @Published public var screen1NavigationLink: Screen1.ViewModel?
        @Published public var showError = false
        
        public init(environment: AppEnvironment) {
            self.environment = environment
        }
        
        public func trigger(_ action: AppCoreAction) {
            switch action {
                
            case .countUp:
                self.count += 1
                
            case .navigateToScreen1Sheet:

                let screen1VM =  Screen1.ViewModel(environment: self.environment, count: self.count)
                
                self.screen1Sheet = screen1VM
                
                return trigger(.setupSheet1SheetPublishers)

            case .navigateToScreen1NavigationLink:
                
                let navLinkVM =  Screen1.ViewModel(environment: self.environment, count: self.count)
                
                self.screen1NavigationLink = navLinkVM
                return trigger(.setupSheet1NavigationLinkPublishers)
                
            case .onDismissScreen1Sheet:
                self.screen1Sheet = nil
                
            case .navigationChangedScreen2:
                self.screen1NavigationLink = nil
                return
                
            case .fetchPerson:
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
                
            case .setupSheet1SheetPublishers:

                
                self.screen1Sheet?.$count
                    .sink { [weak self] in
                        self?.count = $0
                    }
                    .store(in: &cancellables)
                
                self.screen1Sheet?.$close
                    .sink { [weak self] in
                        if $0 {
                            self?.screen1Sheet = nil
                        }
                    }
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

                
            case .setupSheet1NavigationLinkPublishers:

                self.screen1NavigationLink?.$count
                    .sink { [weak self] in
                        self?.count = $0
                    }
                    .store(in: &cancellables)
                
                self.screen1NavigationLink?.$close
                    .sink { [weak self] in
                        if $0 {
                            self?.screen1NavigationLink = nil
                        }
                    }
                    .store(in: &cancellables)

                self.screen1NavigationLink?.$screen2.sink(receiveValue: { [weak self] screen2vm in

                    screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in

                        if bool {
                            self?.screen1NavigationLink = nil
                        }
                    })
                    .store(in: &self!.cancellables)
                })
                .store(in: &cancellables)
            }
        }
    }
}
