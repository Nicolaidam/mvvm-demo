import SwiftUI
import Screen1
import Shared

public struct AppCore: View {
    
    @ObservedObject var vm: ViewModel
    
    public init(environment: AppEnvironment) {
        self.vm = .init(environment: environment)
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
                Text("Amount: \(vm.count)")
                if vm.showError {
                    Text("Error fetching person")
                }
                if let person = vm.person {
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
            .background(
                NavigationLink(
                    isActive: Binding(get: { vm.screen1NavigationLink != nil }, set: {_ in vm.trigger(.navigationChangedScreen2) }),
                    destination: {
                        if let vm = vm.screen1NavigationLink {
                            Screen1(vm: vm)
                        }
                    },
                    label: {
                        EmptyView()
                    }
                )
            )
        }
        .onAppear { vm.trigger(.fetchPerson) }
        .sheet(
            isPresented: Binding(get: { vm.screen1Sheet != nil }, set: { _ in }),
            onDismiss: { vm.trigger(.onDismissScreen1Sheet) },
            content: {
                NavigationView {
                    Screen1(vm: vm.screen1Sheet!)
                }
            }
        )
    }
}

struct Previews_AppCore_Previews: PreviewProvider {
    static var previews: some View {
        AppCore(environment: .mock())
    }
}
