import SwiftUI

struct StreakCard: View {
    @AppStorage("streak") var streak: Int = 1
    var body: some View {
        HStack(spacing: 15) {
            Image("happy-apple")

            VStack(alignment: .leading) {
                Text("Continue assim!")
                    .bold()
                    .font(.title2)
                Text("\(streak) dia(s) registrando suas refeições")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.lightRed)
        .cornerRadius(12)
    }
    
}

#Preview {
    StreakCard()
}
