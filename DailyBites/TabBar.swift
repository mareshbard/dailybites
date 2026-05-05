import SwiftUI

struct TabBar: View {
    
    @SceneStorage("selectedTab") private var selectedTabIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Tab("Refeições", systemImage: "fork.knife", value: 0) {
                HomeView()
            }
            Tab("Estatísticas", systemImage: "chart.pie", value: 1) {
                StatisticsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .accentColor(Color("CordeAção"))
    }
}

#Preview {
    TabBar()
}
