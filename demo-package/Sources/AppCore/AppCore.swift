import SwiftUI
import Screen1

public struct AppCore: View {
    
    @ObservedObject public var vm: AppCoreVM
    
    public init(vm: AppCoreVM) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            Text("AppCore")
            Button {
                vm.navigateToScreen1()
            } label: {
                Text("NavigateToScreen1")
            }

            Button {
                vm.countUp()
            } label: {
                Text("Count up")
            }
            Text("Amount: \(vm.count)")
        }
        .sheet(
            isPresented: Binding(get: { vm.screen1 != nil }, set: { _ in }),
            onDismiss: { vm.onDismiss() },
            content: { Screen1(vm: vm.screen1!) }
        )
    }
}

struct Previews_AppCore_Previews: PreviewProvider {
    static var previews: some View {
        AppCore(vm: .init(apiClient: .mock, mainQueue: .main))
    }
}
