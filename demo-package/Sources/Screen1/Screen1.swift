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
    
    @ObservedObject public var vm: Screen1VM
    
    public init(vm: Screen1VM) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack {
            if vm.showError {
                Text("Error is returned")
            }
            Button {
                vm.closeSheet()
            } label: {
                Text("Navigate back")
            }
            Text("Screen1")
            Text("Count: \(vm.count)")
            Button {
                vm.countUp()
            } label: {
                Text("Count up")
            }
            Button {
                vm.fetchPerson()
            } label: {
                Text("Fetch Person")
            }
            Button {
                vm.navigateToScreen2()
            } label: {
                Text("Navigtionlink to Screen2")
            }
            if vm.isLoading {
                ProgressView()
            } else {
                if let person = vm.person {
                    Text(person.name)
                    Text("\(person.age)")
                }
            }
            
        }
        .navigationTitle(Text("Screen1"))
        .background(
            NavigationLink(
                isActive: Binding(
                    get: { vm.screen2 != nil },
                    set: { _ in vm.navigationChangedScreen2() }),
                destination: {
                    if let vm = vm.screen2 {
                        Screen2(vm: vm)
                    }
                },
                label: {
                    EmptyView()
                }
            )
            
        )
    }
}

struct Previews_Screen1_Previews: PreviewProvider {
    static var previews: some View {
        Screen1(vm: .init(environment: .live(environment: .init(apiClient: .mockSuccess)), count: 99))
    }
}
