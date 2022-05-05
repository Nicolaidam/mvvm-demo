//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import SwiftUI

public struct Screen2: View {
    @ObservedObject public var vm: Screen2VM
    
    public init(vm: Screen2VM) {
        self.vm = vm
    }
    public var body: some View {
        VStack {
            Text("Screen2")
            Button {
                vm.close()
            } label: {
                Text("Close")
            }

        }
    }
}

struct Previews_Screen2_Previews: PreviewProvider {
    static var previews: some View {
        Screen2(vm: .init(environment: .live(environment: .init(apiClient: .mock))))
    }
}
