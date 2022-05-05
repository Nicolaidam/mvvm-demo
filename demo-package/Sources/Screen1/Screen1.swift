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
        NavigationView {
            VStack {
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
                NavigationLink {
                    Screen2(vm: .init(environment: vm.environment.map { .init(apiClient: $0.apiClient) }))
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
        }
    }
}

struct Previews_Screen1_Previews: PreviewProvider {
    static var previews: some View {
        Screen1(vm: .init(environment: .live(environment: .init(apiClient: .mock)), count: 99))
    }
}
