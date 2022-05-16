//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import Screen2
import SwiftUI
import Shared

public struct Screen1: View {
    
    public var vm: ViewModel
    
    public init(initialState: Screen1State, environment: AppEnvironment) {
        self.vm = .init(initialState: initialState, environment: environment)
    }
    
    public var body: some View {
        VStack {
            if vm.state.showError {
                Text("Error is returned")
            }
            Button {
                vm.trigger(.closeSheet)
            } label: {
                Text("Navigate back")
            }
            Text("Screen1")
            Text("Count: \(vm.state.count)")
            Button {
                self.vm.trigger(.countUp)
            } label: {
                Text("Count up")
            }
            Button {
                vm.trigger(.fetchPerson)
            } label: {
                Text("Fetch Person")
            }
            Button {
                vm.trigger(.navigateToScreen2)
            } label: {
                Text("Navigtionlink to Screen2")
            }
            if vm.state.isLoading {
                ProgressView()
            } else {
                if let person = vm.state.person {
                    Text(person.name)
                    Text("\(person.age)")
                }
            }
            
        }
        .navigationTitle(Text("Screen1"))
        .background(
            NavigationLink(
                isActive: Binding(
                    get: { vm.state.screen2 != nil },
                    set: { _ in vm.trigger(.navigationChangedScreen2) }),
                destination: {
                    if let state = vm.state.screen2 {
                        Screen2(initialState: state, environment: vm.environment)
                    }
                },
                label: {
                    EmptyView()
                }
            )
            
        )
    }
}

//struct Previews_Screen1_Previews: PreviewProvider {
//    static var previews: some View {
//        Screen1(vm: .init(environment: .live(environment: .init(apiClient: .mockSuccess)), count: 99))
//    }
//}
