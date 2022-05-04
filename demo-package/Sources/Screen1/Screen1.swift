//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import SwiftUI

public struct Screen1: View {
    
    @ObservedObject public var vm: Screen1VM
    
    public init(vm: Screen1VM) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack {
            Text("Screen1")
            Text("Count: \(vm.count)")
            Button.init {
                vm.fetchPerson()
            } label: {
                Text("Fetch Person")
            }
            if let person = vm.person {
                Text(person.name)
                Text("\(person.age)")
            } else {
                ProgressView()
            }
        }
    }
}

struct Previews_Screen1_Previews: PreviewProvider {
    static var previews: some View {
        Screen1(vm: .init(apiClient: .mock, count: 99))
    }
}
