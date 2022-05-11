import SwiftUI
import Screen1

public struct AppCore: View {
    
    @ObservedObject public var vm: AppCoreVM
    
    public init(vm: AppCoreVM) {
        self.vm = vm
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("AppCore")
                Button {
                    vm.navigateToScreen1NavigationLink()
                } label: {
                    Text("NavigationLink Screen1")
                }
                Button {
                    vm.countUp()
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
                            vm.navigateToScreen1Sheet()
                        } label: {
                            Text("Sheet Screen1")
                        }
                        
                    }
                )
            }
            .background(
                NavigationLink(
                    isActive: Binding(get: { vm.screen1NavigationLink != nil }, set: { _ in }),
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
        .onAppear { vm.fetchPerson() }
        .sheet(
            isPresented: Binding(get: { vm.screen1Sheet != nil }, set: { _ in }),
            onDismiss: { vm.onDismissScreen1Sheet() },
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
        AppCore(vm: .init(
            environment: .live(environment: .init(apiClient: .mockSuccess))))
    }
}
