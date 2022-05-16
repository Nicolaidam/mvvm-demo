//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import Combine
import SwiftUI
import Shared

public struct Screen2: View {
    
    @ObservedObject public var vm: ViewModel
    
    public init(vm: Screen2.ViewModel) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack {
            Text("Screen2")
            Button {
                vm.trigger(.closeButtonTapped)
            } label: {
                Text("Navigate back to home")
            }
        }
        .navigationTitle(Text("Screen2"))
    }
}

struct Previews_Screen2_Previews: PreviewProvider {
    static var previews: some View {
        Screen2(vm: .init(environment: .mock()))
    }
}
