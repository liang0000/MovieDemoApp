import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            NotificationView()
                .tabItem {
                    Label("Notification", systemImage: "ellipsis.message.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .systemGray6
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
