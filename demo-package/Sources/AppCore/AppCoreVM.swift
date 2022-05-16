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

public class AppCoreState: ObservableObject {
    
    @Published public var person: Person? = nil
    @Published public var count: Int = 0
    @Published public var screen1Sheet: Screen1State?
    @Published public var screen1NavigationLink: Screen1State?
    @Published public var showError = false
    
    public init(person: Person? = nil, count: Int = 0, screen1Sheet: Screen1State? = nil, screen1NavigationLink: Screen1State? = nil, showError: Bool = false) {
        self.person = person
        self.count = count
        self.screen1Sheet = screen1Sheet
        self.screen1NavigationLink = screen1NavigationLink
        self.showError = showError
    }
}

public enum AppCoreAction {
    case countUp
    case navigateToScreen1Sheet
    case navigateToScreen1NavigationLink
    case onDismissScreen1Sheet
    case navigationChangedScreen2
    case onDismissScreen1NavigationLink
    case fetchPerson
    case setupSheet1SheetPublishers
    case setupSheet1NavigationLinkPublishers
}

extension AppCore  {
    
    class ViewModel: GenericViewModel {
        
        var state: AppCoreState
        var environment: AppEnvironment
        var cancellables: Set<AnyCancellable> = []
        
        init(state: AppCoreState, environment: AppEnvironment) {
            self.state = state
            self.environment = environment
        }
        
        func trigger(_ action: AppCoreAction) {
            switch action {
                
            case .countUp:
                self.state.count += 1
                
            case .navigateToScreen1Sheet:

                @ObservedObject var screen1State = Screen1State(count: state.count)
                
                self.state.screen1Sheet = screen1State
                
//                self.state.screen1Sheet?.$count
//                    .sink { self.state.count = $0 }
//                    .store(in: &cancellables)

            case .navigateToScreen1NavigationLink:
                self.state.screen1NavigationLink = .init(count: self.state.count)
                
            case .onDismissScreen1Sheet:
                self.state.screen1Sheet = nil
                
            case .navigationChangedScreen2:
                return
                
            case .onDismissScreen1NavigationLink:
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
                                self?.state.showError = true
                            case .finished:
                                print("Publisher is finished")
                            }
                        },
                        receiveValue: { [weak self] person in
                            self?.state.person = person
                        })
                    .store(in: &cancellables)
                
            case .setupSheet1SheetPublishers:
                
                return
                //                self.screen1Sheet?.$close
                //                    .sink(receiveValue: { [weak self] value in
                //                        if value {
                //                            self?.onDismissScreen1Sheet()
                //                        }
                //                    })
                //                    .store(in: &cancellables)
                //
                //                self.state.screen1Sheet?.$screen2.sink(receiveValue: { [weak self] screen2vm in
                //
                //                    screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in
                //
                //                        if bool {
                //                            self?.screen1Sheet = nil
                //                        }
                //                    })
                //                    .store(in: &self!.cancellables)
                //                })
                //                .store(in: &cancellables)
                
            case .setupSheet1NavigationLinkPublishers:
                return
                //                self.state.screen1NavigationLink?.$count
                //                    .sink(receiveValue: { [weak self] value in
                //                        self?.count = value
                //                    })
                //                    .store(in: &cancellables)
                //
                //                self.state.screen1NavigationLink?.$close
                //                    .sink(receiveValue: { [weak self] value in
                //                        if value {
                //                            self?.onDismissScreen1NavigationLink()
                //                        }
                //                    })
                //                    .store(in: &cancellables)
                //
                //                self.state.screen1NavigationLink?.$screen2.sink(receiveValue: { [weak self] screen2vm in
                //
                //                    screen2vm?.$closeTapped.sink(receiveValue: { [weak self]  bool in
                //
                //                        if bool {
                //                            self?.screen1Sheet = nil
                //                        }
                //                    })
                //                    .store(in: &self!.cancellables)
                //                })
                //                .store(in: &cancellables)
                
            }
        }
    }
}
