import SwiftUI

struct TabBar: View {
    
    @SceneStorage("selectedTab") private var selectedTabIndex: Int = 0
   // var listTips : [Dicas] = []
 
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Tab("Refeições", systemImage: "fork.knife", value: 0) {
                HomeView()
            }
            Tab("Estatísticas", systemImage: "chart.pie", value: 1) {
                StatisticsView()
            }
            Tab("Registros", systemImage: "calendar", value: 2){
                MealsRecordedView()
            }
            Tab("Dicas", systemImage: "book", value: 3){
                TipsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .accentColor(Color("RoxoAcao"))
    }
}

#Preview {
    TabBar()
}
