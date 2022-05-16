import SwiftUI
import Screen1
import Shared

public struct AppCore: View {
    
    var vm: ViewModel
    
    public init(initialState: AppCoreState, environment: AppEnvironment) {
        self.vm = .init(state: initialState, environment: environment)
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("AppCore")
                Button {
                    vm.trigger(.navigateToScreen1NavigationLink)
                } label: {
                    Text("NavigationLink Screen1")
                }
                Button {
                    vm.trigger(.countUp)
                } label: {
                    Text("Count up")
                }
                Text("Amount: \(vm.state.count)")
                if vm.state.showError {
                    Text("Error fetching person")
                }
                if let person = vm.state.person {
                    Text(person.name)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle(Text("Home"))
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing,
                    content: {
                        Button {
                            vm.trigger(.navigateToScreen1Sheet)
                        } label: {
                            Text("Sheet Screen1")
                        }
                        
                    }
                )
            }
            
            //            .background(
            //                NavigationLink(
            //                    isActive: Binding(get: { vm.screen1NavigationLink != nil }, set: { _ in }),
            //                    destination: {
            //                        if let vm = vm.screen1NavigationLink {
            //                            Screen1(vm: vm)
            //                        }
            //                    },
            //                    label: {
            //                        EmptyView()
            //                    }
            //                )
            //            )
        }
        .onAppear { vm.trigger(.fetchPerson) }
        .sheet(
            isPresented: Binding(get: { vm.state.screen1Sheet != nil }, set: { _ in }),
            onDismiss: { vm.trigger(.onDismissScreen1Sheet) },
            content: {
                NavigationView {
                        Screen1(initialState: vm.state.screen1Sheet!, environment: vm.environment)
//                        .onChange(of: vm.state.screen1Sheet?.count) { newValue in
//                            vm.trigger(.countUp)
//                        }
                }
            }
        )
    }
}
//
//struct Previews_AppCore_Previews: PreviewProvider {
//    static var previews: some View {
//        AppCore(vm: .init(
//            environment: .live(environment: .init(apiClient: .mockSuccess))))
//    }
//}
