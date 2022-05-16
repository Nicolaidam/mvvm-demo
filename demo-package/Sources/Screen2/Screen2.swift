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
    
    public var viewModel: ViewModel
    
    public init(initialState: Screen2State, environment: AppEnvironment) {
        self.viewModel = ViewModel(state: initialState, environment: environment)
    }
    
    public var body: some View {
        VStack {
            Text("Screen2")
            Button {
                viewModel.trigger(.closeButtonTapped)
            } label: {
                Text("Navigate back to home")
            }
        }
        .navigationTitle(Text("Screen1"))
    }
}

struct Previews_Screen2_Previews: PreviewProvider {
    static var previews: some View {
        Screen2(initialState: .init(), environment: .mock())
    }
}
