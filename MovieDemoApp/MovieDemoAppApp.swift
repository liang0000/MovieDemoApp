import SwiftUI

@main
struct MovieDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ModelData())
        }
    }
}
